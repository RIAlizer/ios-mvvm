//
//  MathHelper.h
//  Codr Ltd
//
//  Created by Andrea Gonteri on 08/10/2014.
//  Copyright (c) 2014 Codr Ltd. All rights reserved.
//

#pragma once

static inline float RoundTo(float number, float interval)
{
    if (number >= 0)
    {
        return interval * floorf(number / interval + 0.5f);
    }
    else
    {
        return interval * ceilf(number / interval - 0.5f);
    }
}

static inline float RoundUp(float number, float interval)
{
    if (number >= 0)
    {
        return interval * ceilf(number / interval);
    }
    else
    {
        return interval * floorf(number / interval);
    }
}
