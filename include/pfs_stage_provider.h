/* Copyright (c) 2012, 2014, Oracle and/or its affiliates. All rights reserved.

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; version 2 of the License.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software Foundation,
  51 Franklin Street, Suite 500, Boston, MA 02110-1335 USA */

#ifndef PFS_STAGE_PROVIDER_H
#define PFS_STAGE_PROVIDER_H

/**
  @file include/pfs_stage_provider.h
  Performance schema instrumentation (declarations).
*/

#ifdef WITH_PERFSCHEMA_STORAGE_ENGINE
#ifdef MYBLOCKCHAIN_SERVER
#ifndef EMBEDDED_LIBRARY
#ifndef MYBLOCKCHAIN_DYNAMIC_PLUGIN

#include "myblockchain/psi/psi.h"

#define PSI_STAGE_CALL(M) pfs_ ## M ## _v1

C_MODE_START

void pfs_register_stage_v1(const char *category,
                           PSI_stage_info_v1 **info_array,
                           int count);

PSI_stage_progress* pfs_start_stage_v1(PSI_stage_key key, const char *src_file, int src_line);
PSI_stage_progress* pfs_get_current_stage_progress_v1();

void pfs_end_stage_v1();

C_MODE_END

#endif /* MYBLOCKCHAIN_DYNAMIC_PLUGIN */
#endif /* EMBEDDED_LIBRARY */
#endif /* MYBLOCKCHAIN_SERVER */
#endif /* WITH_PERFSCHEMA_STORAGE_ENGINE */

#endif

