/*
 * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Change Logs:
 * Date           Author       Notes
 * 2022-10-08     Yuefu Su   first implementation
 */

#include <rthw.h>
#include <rtthread.h>

#ifdef RT_USING_ISP3
#include "drv_isp3.h"
#endif

#ifdef RT_USING_SC501AI
#include "board.h"
#include "camera.h"

const struct camera_board_desc camera_sc501ai =
{
	.i2c_addr = 0x30,
	.rst_gpio =
	{
		.gpio_pin = GPIO_PIN_C5,
		.gpio_group = GPIO3,
	},
	.pwdn_gpio =
	{
		.gpio_pin = GPIO_PIN_C6,
		.gpio_group = GPIO3,
	},
	.time_valid_delay = 2,
	.gain_valid_delay = 2,
	.mode_id = SC501AI_1440X810,
	.isp_subdev_name = RK_ISP_MAIN_SUBDEV_NAME,
	.i2c_bus = "i2c4",
	.rst_active = 0,
	.mclk_id = CLK_REF_MIPI0,
        .mclk_out_gate_id = CLK_REF_MIPI0_OUT_GATE,
};
#endif

#ifdef RT_USING_ISP3
void cif_hw_config(void)
{
    struct dphy_board_desc *csi2_dphy = (struct dphy_board_desc *)&csi2_dphy_board;
    struct csi2_board_desc *csi_host_0 = (struct csi2_board_desc *)&csi2_host0_board;
    struct vicap_board_desc *vicap = (struct vicap_board_desc *)&vicap_board;

    csi2_dphy->enable = true;
    csi2_dphy->csi2_dphy1.enable = true;
    csi2_dphy->csi2_dphy1.csi_host_idx = 0;
    csi2_dphy->csi2_dphy1.data_lanes = 2;
    csi2_dphy->csi2_dphy1.isp_subdev_name = RK_ISP_MAIN_SUBDEV_NAME;

    csi_host_0->enable = true;

    vicap->enable = true;
}
#endif
