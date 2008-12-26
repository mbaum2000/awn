/*
 *  Copyright (C) 2007 Michal Hruby <michal.mhr@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include "awn-effect-desaturate.h"

#include <math.h>
#include <string.h>
#include <stdlib.h>

gboolean
desaturate_effect(AwnEffectsAnimation * anim)
{
  AwnEffectsPrivate *priv = anim->effects->priv;

  if (!priv->effect_lock)
  {
    priv->effect_lock = TRUE;
    // effect start initialize values
    priv->direction = AWN_EFFECT_DIR_DOWN;
    priv->saturation = 1.0;

    if (anim->start)
      anim->start(priv->self);

    anim->start = NULL;
  }

  const gdouble DESATURATION_STEP = 0.04;

  switch (priv->direction)
  {

    case AWN_EFFECT_DIR_DOWN:
      priv->saturation -= DESATURATION_STEP;

      if (priv->saturation < 0)
        priv->saturation = 0;

      if (awn_effect_check_top_effect(anim, NULL))
      {
        awn_effects_redraw(anim->effects);
        if (priv->saturation > 0) return TRUE;
        else {
          return awn_effect_suspend_animation(anim,
                                              (GSourceFunc)desaturate_effect);
        }
      }
      else
        priv->direction = AWN_EFFECT_DIR_UP;

      break;

    case AWN_EFFECT_DIR_UP:

    default:
      priv->saturation += DESATURATION_STEP;
  }

  // repaint widget
  awn_effects_redraw(anim->effects);

  gboolean repeat = TRUE;

  if (priv->saturation >= 1.0)
  {
    priv->saturation = 1.0;
    priv->direction = AWN_EFFECT_DIR_DOWN;
    // check for repeating
    repeat = awn_effect_handle_repeating(anim);
  }

  return repeat;
}

gboolean
desaturate_effect_finalize(AwnEffectsAnimation * anim)
{

  return TRUE;
}
