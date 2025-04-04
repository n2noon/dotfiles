#pragma once

/* The way how "handedness" is decided (which half is which),
see https://docs.qmk.fm/#/feature_split_keyboard?id=setting-handedness
for more options.
*/

#define COMBO_MUST_TAP_PER_COMBO

// save some space
#define NO_ACTION_ONESHOT
#define NO_MUSIC_MODE
#define LAYER_STATE_8BIT
#undef TAPPING_TERM
#define TAPPING_TERM 50
#define HOLD_ON_OTHER_KEY_PRESS
#define RETRO_TAPPING

#undef LOCKING_SUPPORT_ENABLE
#undef LOCKING_RESYNC_ENABLE

// this is needed because reasons
#define SPLIT_USB_DETECT
#define SPLIT_WATCHDOG_ENABLE
