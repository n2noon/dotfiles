/* Copyright 2023 @ Keychron (https://www.keychron.com)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "action_util.h"
#include "config.h"
#include "keycodes.h"
#include "modifiers.h"
#include "quantum_keycodes.h"
#include QMK_KEYBOARD_H
#include "keychron_common.h"
/*#include "features/achordion.h"*/

enum layers {
    WIN_BASE,
    WIN_ONE_ROW_DOWN,
    WIN_FN,
    MAC_BASE,
    MAC_ONE_ROW_DOWN,
    MAC_FN,
};
/**/
/*uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {*/
/*    switch (keycode) {*/
/*        case CTL_T(KC_ESC):*/
/*            return 20;*/
/*        case LALT_T(KC_SPC):*/
/*            return 190;*/
/*        default:*/
/*            return TAPPING_TERM;*/
/*    }*/
/*}*/
/**/
/*uint16_t get_quick_tap_term(uint16_t keycode, keyrecord_t* record) {*/
/*  // If you quickly hold a tap-hold key after tapping it, the tap action is*/
/*  // repeated. Key repeating is useful e.g. for Vim navigation keys, but can*/
/*  // lead to missed triggers in fast typing. Here, returning 0 means we*/
/*  // instead want to "force hold" and disable key repeating.*/
/*  switch (keycode) {*/
/*    // Repeating is useful for Vim navigation keys.*/
/*    case KC_W:*/
/*    case KC_J:*/
/*    case KC_K:*/
/*    case KC_L:*/
/*    case KC_DOWN:*/
/*    case KC_UP:*/
/*    case KC_LEFT:*/
/*    case KC_RIGHT:*/
/*      return QUICK_TAP_TERM - 150;  // Enable key repeating.*/
/*    default:*/
/*      return 0;  // Otherwise, force hold and disable key repeating.*/
/*  }*/
/*}*/
/**/
// clang-format off
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    /* TODO - update this
     * ┌───┐   ┌───┬───┬───┬───┐ ┌───┬───┬───┬───┐ ┌───┬───┬───┬───┐ ┌───┬───┬───┐
     * │Esc│   │F1 │F2 │F3 │F4 │ │F5 │F6 │F7 │F8 │ │F9 │F10│F11│F12│ │PSc│Scr│Pse│
     * └───┘   └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┘
     * ┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───────┐ ┌───┬───┬───┐
     * │ ` │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 8 │ 9 │ 0 │ - │ = │ Backsp│ │Ins│Hom│PgU│
     * ├───┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─────┤ ├───┼───┼───┤
     * │ Tab │ Q │ W │ E │ R │ T │ Y │ U │ I │ O │ P │ [ │ ] │  \  │ │Del│End│PgD│
     * ├─────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴─────┤ └───┴───┴───┘
     * │Ct/Esc│ A │ S │ D │ F │ G │ H │ J │ K │ L │ ; │ ' │  Enter │
     * ├──────┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴────────┤     ┌───┐
     * │ Shift  │ Z │ X │ C │ V │ B │ N │ M │ , │ . │ / │    Shift │     │ ↑ │
     * ├────┬───┴┬──┴─┬─┴───┴───┴───┴───┴───┴──┬┴───┼───┴┬────┬────┤ ┌───┼───┼───┐
     * │Ctrl│GUI │Alt │                        │ Alt│ GUI│Menu│Ctrl│ │ ← │ ↓ │ → │
     * └────┴────┴────┴────────────────────────┴────┴────┴────┴────┘ └───┴───┴───┘
     */
     [WIN_BASE] = LAYOUT_tkl_ansi(
        KC_ESC,             KC_F1,    KC_F2,    KC_F3,         KC_F4,    KC_F5,    KC_F6,    KC_F7,    KC_F8,    KC_F9,    KC_F10,   KC_F11,     KC_F12,   KC_PSCR,  KC_SCRL,  KC_PAUS,
        KC_GRV,   KC_1,     KC_2,     KC_3,     KC_4,          KC_5,     KC_6,     KC_7,     KC_8,     KC_9,     KC_0,     KC_MINS,  KC_EQL,     KC_BSPC,  KC_INS,   KC_HOME,  KC_PGUP,
        KC_TAB,   KC_Q,     KC_W,     KC_E,     KC_R,          KC_T,     KC_Y,     KC_U,     KC_I,     KC_O,     KC_P,     KC_LBRC,  KC_RBRC,    KC_BSLS,  KC_DEL,   KC_END,   KC_PGDN,
        /*CTL_T(KC_ESC) ,KC_A, LALT_T(KC_S), CTL_T(KC_D), LSFT_T(KC_F),   KC_G,    KC_H,   RSFT_T(KC_J), CTL_T(KC_K), RALT_T(KC_L), KC_SCLN, KC_QUOT,              KC_ENT,*/
        CTL_T(KC_ESC),  KC_A,     KC_S,     KC_D,     KC_F,     KC_G,     KC_H,     KC_J,     KC_K,     KC_L,     KC_SCLN,  KC_QUOT,              KC_ENT,
        KC_LSFT,            KC_Z,     KC_X,     KC_C,          KC_V,     KC_B,     KC_N,     KC_M,     KC_COMM,  KC_DOT,   KC_SLSH,              KC_RSFT,            KC_UP,
        KC_LCTL,  KC_LWIN,  KC_LALT,                                KC_SPC,                                 MO(WIN_ONE_ROW_DOWN),  MO(WIN_FN),KC_APP,    KC_RCTL,  KC_LEFT,  KC_DOWN,  KC_RGHT),

     [WIN_ONE_ROW_DOWN] = LAYOUT_tkl_ansi(
        _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,    _______,  _______,  _______,  _______,
        KC_GRV,   KC_1,     KC_2,     KC_3,     KC_4,          KC_5,     KC_6,     KC_7,     KC_8,     KC_9,     KC_0,     KC_MINS,  KC_EQL,     KC_BSPC,  KC_INS,   KC_HOME,  KC_PGUP,
        KC_GRV,   KC_1,     KC_2,     KC_3,     KC_4,          KC_5,     KC_6,     KC_7,     KC_8,     KC_9,     KC_0,     KC_MINS,  KC_EQL,     KC_BSPC,  KC_INS,   KC_HOME,  KC_PGUP,
        /*CTL_T(KC_ESC) ,KC_A, LALT_T(KC_S), CTL_T(KC_D), LSFT_T(KC_F),   KC_G,    KC_H,   RSFT_T(KC_J), CTL_T(KC_K), RALT_T(KC_L), KC_SCLN, KC_QUOT,              KC_ENT,*/
        CTL_T(KC_ESC),  KC_A,     KC_S,     KC_D,     KC_F,     KC_G,     KC_H,     KC_J,     KC_K,     KC_L,     KC_SCLN,  KC_QUOT,              KC_ENT,
        KC_LSFT,            KC_Z,     KC_X,     KC_C,          KC_V,     KC_B,     KC_N,     KC_M,     KC_COMM,  KC_DOT,   KC_SLSH,              KC_RSFT,            KC_UP,
        KC_LCTL,  KC_LWIN,  KC_LALT,                                KC_SPC,                                 KC_RALT,  MO(WIN_FN),KC_APP,    KC_RCTL,  KC_LEFT,  KC_DOWN,  KC_RGHT),

     [WIN_FN] = LAYOUT_tkl_ansi(
        _______,            KC_BRID,  KC_BRIU,  KC_TASK,  KC_FLXP,  BL_DOWN,  BL_UP,    KC_MPRV,  KC_MPLY,  KC_MNXT,  KC_MUTE,  KC_VOLD,    KC_VOLU,  QK_BOOT,  KC_CRTA,  BL_STEP,
        _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,    _______,  _______,  _______,  _______,
        BL_TOGG,  BL_STEP,  BL_UP,    _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,    _______,  _______,  _______,  _______,
        KC_OSSW,  _______,  BL_DOWN,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,              _______,
        _______,            _______,  _______,  _______,  _______,  _______,  NK_TOGG,  _______,  _______,  _______,  _______,              _______,            DT_UP,
        _______,  GU_TOGG,  _______,                                _______,                                _______,  _______,  _______,    _______,  _______,  DT_DOWN,  DT_PRNT),

 	 [MAC_BASE] = LAYOUT_tkl_ansi(
        KC_ESC,             KC_BRID,  KC_BRIU,  KC_MICT,  KC_LAPA,  BL_DOWN,  BL_UP,    KC_MPRV,  KC_MPLY,  KC_MNXT,  KC_MUTE,  KC_VOLD,    KC_VOLU,  KC_SNAP,  KC_TRNS,  KC_PAUS,
        KC_GRV,   KC_1,     KC_2,     KC_3,     KC_4,     KC_5,     KC_6,     KC_7,     KC_8,     KC_9,     KC_0,     KC_MINS,  KC_EQL,     KC_BSPC,  KC_INS,   KC_HOME,  KC_PGUP,
        KC_TAB,   KC_Q,     KC_W,     KC_E,     KC_R,     KC_T,     KC_Y,     KC_U,     KC_I,     KC_O,     KC_P,     KC_LBRC,  KC_RBRC,    KC_BSLS,  KC_DEL,   KC_END,   KC_PGDN,
        KC_CAPS,  KC_A,     KC_S,     KC_D,     KC_F,     KC_G,     KC_H,     KC_J,     KC_K,     KC_L,     KC_SCLN,  KC_QUOT,              KC_ENT,
        KC_LSFT,            KC_Z,     KC_X,     KC_C,     KC_V,     KC_B,     KC_N,     KC_M,     KC_COMM,  KC_DOT,   KC_SLSH,              KC_RSFT,            KC_UP,
        KC_LCTL,  KC_LOPTN, KC_LCMMD,                               KC_SPC,                                 KC_RCMMD, MO(MAC_FN),KC_TRNS,   KC_RCTL,  KC_LEFT,  KC_DOWN,  KC_RGHT),

     [MAC_ONE_ROW_DOWN] = LAYOUT_tkl_ansi(
        _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,    _______,  _______,  _______,  _______,
        KC_GRV,   KC_1,     KC_2,     KC_3,     KC_4,          KC_5,     KC_6,     KC_7,     KC_8,     KC_9,     KC_0,     KC_MINS,  KC_EQL,     KC_BSPC,  KC_INS,   KC_HOME,  KC_PGUP,
        KC_GRV,   KC_1,     KC_2,     KC_3,     KC_4,          KC_5,     KC_6,     KC_7,     KC_8,     KC_9,     KC_0,     KC_MINS,  KC_EQL,     KC_BSPC,  KC_INS,   KC_HOME,  KC_PGUP,
        /*CTL_T(KC_ESC) ,KC_A, LALT_T(KC_S), CTL_T(KC_D), LSFT_T(KC_F),   KC_G,    KC_H,   RSFT_T(KC_J), CTL_T(KC_K), RALT_T(KC_L), KC_SCLN, KC_QUOT,              KC_ENT,*/
        CTL_T(KC_ESC),  KC_A,     KC_S,     KC_D,     KC_F,     KC_G,     KC_H,     KC_J,     KC_K,     KC_L,     KC_SCLN,  KC_QUOT,              KC_ENT,
        KC_LSFT,            KC_Z,     KC_X,     KC_C,     KC_V,     KC_B,     KC_N,     KC_M,     KC_COMM,  KC_DOT,   KC_SLSH,              KC_RSFT,            KC_UP,
        KC_LCTL,  KC_LOPTN, KC_LCMMD,                               KC_SPC,                                 KC_RCMMD, MO(MAC_FN),KC_TRNS,   KC_RCTL,  KC_LEFT,  KC_DOWN,  KC_RGHT),
     [MAC_FN] = LAYOUT_tkl_ansi(
        _______,            KC_F1,    KC_F2,    KC_F3,    KC_F4,    KC_F5,    KC_F6,    KC_F7,    KC_F8,    KC_F9,    KC_F10,   KC_F11,     KC_F12,   QK_BOOT,  KC_SIRI,  BL_STEP,
        _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,    _______,  _______,  _______,  _______,
        BL_TOGG,  BL_STEP,  BL_UP,    _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,    _______,  _______,  _______,  _______,
        KC_OSSW,  _______,  BL_DOWN,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,              _______,
        _______,            _______,  _______,  _______,  _______,  _______,  NK_TOGG,  _______,  _______,  _______,  _______,              _______,            _______,
        _______,  _______,  _______,                                _______,                                _______,  _______,  _______,    _______,  _______,  _______,  _______),
};

const key_override_t ctrl_h_to_left = ko_make_basic(MOD_MASK_CTRL, KC_H, KC_LEFT);
const key_override_t ctrl_l_to_right = ko_make_basic(MOD_MASK_CTRL, KC_L, KC_RIGHT);
const key_override_t ctrl_k_to_up = ko_make_basic(MOD_MASK_CTRL, KC_K, KC_UP);
const key_override_t ctrl_j_to_down = ko_make_basic(MOD_MASK_CTRL, KC_J, KC_DOWN);

// This globally defines all key overrides to be used
const key_override_t *key_overrides[] = {
    &ctrl_h_to_left,
    &ctrl_j_to_down,
    &ctrl_k_to_up,
    &ctrl_l_to_right,
};

/*void matrix_scan_user(void) {*/
    /*achordion_task();*/
/*}*/

// clang-format on
void housekeeping_task_user(void) {
    housekeeping_task_keychron();
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    /*if (!process_achordion(keycode, record)) { return false; }*/
    if (!process_record_keychron(keycode, record)) {
        return false;
    }
    switch (keycode) {
        case LCTL_T(KC_ESC):
            // Detect the activation of only Left Alt
            if (get_mods() == MOD_BIT(KC_LALT) || get_mods() == MOD_BIT(KC_RALT)) {
                if (record->event.pressed) {
                    // No need to register KC_LALT because it's already active.
                    // The Alt modifier will apply on this KC_TAB.
                    register_code(KC_TAB);
                } else {
                    unregister_code(KC_TAB);
                }
                return false;
            }
            return true;

        case KC_RIGHT_CTRL:
            if (record->event.pressed) {
                register_code(KC_LALT);
                register_code(KC_TAB);
            } else {
                unregister_code(KC_LALT);
                unregister_code(KC_TAB);
            }
            return false;
    }
    return true;
}
