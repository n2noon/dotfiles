VIA_ENABLE = no
LTO_ENABLE = yes
AVR_USE_MINIMAL_PRINTF = yes
CONSOLE_ENABLE = no
COMMAND_ENABLE = no
MOUSEKEY_ENABLE = no
MUSIC_ENABLE = no

KEY_OVERRIDE_ENABLE = yes
DYNAMIC_TAPPING_TERM_ENABLE = yes

VPATH += keyboards/keychron/common
SRC += keychron_common.c
# SRC += features/achordion.c
