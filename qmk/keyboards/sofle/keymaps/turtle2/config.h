// Copyright 2024 Santosh Kumar (@santosh)
// SPDX-License-Identifier: GPL-2.0-or-later

#pragma once

#define TRI_LAYER_LOWER_LAYER 1
#define TRI_LAYER_UPPER_LAYER 2
#define TRI_LAYER_ADJUST_LAYER 3
#define SPLIT_USB_DETECT
#define SPLIT_WATCHDOG_ENABLE
/*#define RETRO_TAPPING*/
#define PERMISSIVE_HOLD
#define HOLD_ON_OTHER_KEY_PRESS

// AVR optimisations
#undef LOCKING_SUPPORT_ENABLE
#undef LOCKING_RESYNC_ENABLE
#define NO_MUSIC_MODE
#define LAYER_STATE_8BIT
