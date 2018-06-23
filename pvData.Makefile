#
#  Copyright (c) 2018 - Present  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# 
# Author  : Jeong Han Lee
# email   : jeonghan.lee@gmail.com
# Date    : Saturday, June 23 22:52:15 CEST 2018
# version : 0.0.1
#
where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include $(E3_REQUIRE_TOOLS)/driver.makefile
include $(where_am_I)/configure/CONFIG_PVDATA_VERSION

## Exclude linux-ppc64e6500
##EXCLUDE_ARCHS = linux-ppc64e6500

PVDATA_SRC:=src

MISC:=$(PVDATA_SRC)/misc
PV:=$(PVDATA_SRC)/pv
FACTORY:=$(PVDATA_SRC)/factory
PROPERTY:=$(PVDATA_SRC)/property
COPY:=$(PVDATA_SRC)/copy
PVMISC:=$(PVDATA_SRC)/pvMisc
JSON:=$(PVDATA_SRC)/json


USR_INCLUDES += -I$(COMMON_DIR)
USR_INCLUDES += -I$(where_am_I)$(PVDATA_SRC)
USR_INCLUDES += -I$(where_am_I)$(MISC)
USR_INCLUDES += -I$(where_am_I)$(PROPERTY)

HEADERS += $(MISC)/pv/noDefaultMethods.h
HEADERS += $(MISC)/pv/lock.h
HEADERS += $(MISC)/pv/serialize.h
HEADERS += $(MISC)/pv/bitSet.h
HEADERS += $(MISC)/pv/byteBuffer.h
HEADERS += $(MISC)/pv/epicsException.h
HEADERS += $(MISC)/pv/serializeHelper.h
HEADERS += $(MISC)/pv/event.h
HEADERS += $(MISC)/pv/thread.h
HEADERS += $(MISC)/pv/timer.h
HEADERS += $(MISC)/pv/status.h
HEADERS += $(MISC)/pv/sharedPtr.h
HEADERS += $(MISC)/pv/debugPtr.h
HEADERS += $(MISC)/pv/localStaticLock.h
HEADERS += $(MISC)/pv/typeCast.h
HEADERS += $(MISC)/pv/sharedVector.h
HEADERS += $(MISC)/pv/templateMeta.h
HEADERS += $(MISC)/pv/current_function.h
HEADERS += $(MISC)/pv/pvUnitTest.h
HEADERS += $(MISC)/pv/reftrack.h
HEADERS += $(MISC)/pv/anyscalar.h

SOURCES += $(MISC)/byteBuffer.cpp
SOURCES += $(MISC)/bitSet.cpp
SOURCES += $(MISC)/epicsException.cpp
SOURCES += $(MISC)/serializeHelper.cpp
SOURCES += $(MISC)/event.cpp
SOURCES += $(MISC)/timer.cpp
SOURCES += $(MISC)/status.cpp
SOURCES += $(MISC)/localStaticLock.cpp
SOURCES += $(MISC)/typeCast.cpp
SOURCES += $(MISC)/parseToPOD.cpp
SOURCES += $(MISC)/pvUnitTest.cpp
SOURCES += $(MISC)/debugPtr.cpp
SOURCES += $(MISC)/reftrack.cpp
SOURCES += $(MISC)/anyscalar.cpp



# PV
HEADERS += $(PV)/pvType.h
HEADERS += $(PV)/pvIntrospect.h
HEADERS += $(PV)/valueBuilder.h
HEADERS += $(PV)/pvData.h
HEADERS += $(PV)/convert.h
HEADERS += $(PV)/standardField.h
HEADERS += $(PV)/standardPVField.h
HEADERS += $(PV)/pvSubArrayCopy.h
HEADERS += $(PV)/typemap.h
HEADERS += $(PV)/pvdVersion.h
#HEADERS += $(PV)/pvdVersionNum.h
HEADERS += $(COMMON_DIR)/pv/pvdVersionNum.h
SOURCES += $(PV)/pvdVersion.cpp
SOURCES += $(PV)/valueBuilder.cpp


# FACTORY
HEADERS += $(FACTORY)/pv/factory.h
SOURCES += $(FACTORY)/TypeFunc.cpp
SOURCES += $(FACTORY)/FieldCreateFactory.cpp
SOURCES += $(FACTORY)/PVField.cpp
SOURCES += $(FACTORY)/PVScalar.cpp
SOURCES += $(FACTORY)/PVArray.cpp
SOURCES += $(FACTORY)/PVScalarArray.cpp
SOURCES += $(FACTORY)/PVStructure.cpp
SOURCES += $(FACTORY)/PVStructureArray.cpp
SOURCES += $(FACTORY)/PVUnion.cpp
SOURCES += $(FACTORY)/PVUnionArray.cpp
SOURCES += $(FACTORY)/PVDataCreateFactory.cpp
SOURCES += $(FACTORY)/Convert.cpp
SOURCES += $(FACTORY)/pvSubArrayCopy.cpp
SOURCES += $(FACTORY)/Compare.cpp
SOURCES += $(FACTORY)/StandardField.cpp
SOURCES += $(FACTORY)/StandardPVField.cpp
SOURCES += $(FACTORY)/printer.cpp


# PROPERTY
HEADERS += $(PROPERTY)/pv/alarm.h
HEADERS += $(PROPERTY)/pv/pvAlarm.h
HEADERS += $(PROPERTY)/pv/control.h
HEADERS += $(PROPERTY)/pv/pvControl.h
HEADERS += $(PROPERTY)/pv/display.h
HEADERS += $(PROPERTY)/pv/pvDisplay.h
HEADERS += $(PROPERTY)/pv/pvEnumerated.h
HEADERS += $(PROPERTY)/pv/timeStamp.h
HEADERS += $(PROPERTY)/pv/pvTimeStamp.h
SOURCES += $(PROPERTY)/alarm.cpp
SOURCES += $(PROPERTY)/pvAlarm.cpp
SOURCES += $(PROPERTY)/pvControl.cpp
SOURCES += $(PROPERTY)/pvDisplay.cpp
SOURCES += $(PROPERTY)/pvEnumerated.cpp
SOURCES += $(PROPERTY)/timeStamp.cpp
SOURCES += $(PROPERTY)/pvTimeStamp.cpp


# COPY
HEADERS += $(COPY)/pv/createRequest.h
HEADERS += $(COPY)/pv/pvCopy.h
SOURCES += $(COPY)/createRequest.cpp
SOURCES += $(COPY)/pvCopy.cpp


# PVMISC
HEADERS += $(PVMISC)/pv/bitSetUtil.h
SOURCES += $(PVMISC)/bitSetUtil.cpp


# JSON
HEADERS += $(JSON)/pv/json.h
SOURCES += $(JSON)/parsehelper.cpp
SOURCES += $(JSON)/parseany.cpp
SOURCES += $(JSON)/parseinto.cpp
SOURCES += $(JSON)/print.cpp



print$(DEP): $(COMMON_DIR)/pv/pvdVersionNum.h
	@echo  $(HOSTEXE)

EXPANDVARS += EPICS_PVD_MAJOR_VERSION
EXPANDVARS += EPICS_PVD_MINOR_VERSION
EXPANDVARS += EPICS_PVD_MAINTENANCE_VERSION
EXPANDVARS += EPICS_PVD_DEVELOPMENT_FLAG

EXPANDFLAGS += $(foreach var,$(EXPANDVARS),-D$(var)="$(strip $($(var)))")

# shared library ABI version.
#SHRLIB_VERSION = $(EPICS_PVD_MAJOR_VERSION).$(EPICS_PVD_MINOR_VERSION).$(EPICS_PVD_MAINTENANCE_VERSION)


# Can't use EXPAND as generated headers must appear
# in O.Common, but EXPAND emits rules for O.$(T_A)
$(COMMON_DIR)/pv/pvdVersionNum.h: $(PV)/pvdVersionNum.h@
	$(MKDIR) $(COMMON_DIR)/pv
	$(EXPAND_TOOL) $(EXPANDFLAGS) $($@_EXPANDFLAGS) $< $@




## This RULE should be used in case of inflating DB files 
## db rule is the default in RULES_DB, so add the empty one
## Please look at e3-mrfioc2 for example.

db: 

.PHONY: db 

# EPICS_BASE_HOST_BIN = $(EPICS_BASE)/bin/$(EPICS_HOST_ARCH)
# MSI = $(EPICS_BASE_HOST_BIN)/msi
#
# USR_DBFLAGS += -I . -I ..
# USR_DBFLAGS += -I $(EPICS_BASE)/db
# USR_DBFLAGS += -I $(APPDB)
#
# SUBS=$(wildcard $(APPDB)/*.substitutions)
# TMPS=$(wildcard $(APPDB)/*.template)
#
# db: $(SUBS) $(TMPS)

# $(SUBS):
#	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
#	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
#	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db -S $@  > $(basename $(@)).db.d
#	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db -S $@

# $(TMPS):
#	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
#	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
#	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db $@  > $(basename $(@)).db.d
#	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db $@

#
# .PHONY: db $(SUBS) $(TMPS)

vlibs:

.PHONY: vlibs

# vlibs: $(VENDOR_LIBS)

# $(VENDOR_LIBS):
# 	$(QUIET) $(SUDO) install -m 555 -d $(E3_MODULES_VENDOR_LIBS_LOCATION)/
# 	$(QUIET) $(SUDO) install -m 555 $@ $(E3_MODULES_VENDOR_LIBS_LOCATION)/

# .PHONY: $(VENDOR_LIBS) vlibs



