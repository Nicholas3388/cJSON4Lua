CC = gcc
CFLAGS = -c -Wall -g
LIBS = -lm

SRC_DIR = .
APP = app


EXTS := *.C *.c *.cxx *.CXX *.cpp *.CPP *.cc *.CC  
DIRS := ${shell find ${SRC_DIR} -type d -print}  
SRCS := $(foreach dir,$(DIRS),$(wildcard $(addprefix $(dir)/,$(EXTS))))  
CFLAGS += $(foreach dir,$(DIRS), $(addprefix -I,$(dir)))  
OBJS := $(addsuffix .o, $(SRCS))  
  
define CMPL_APP  
$(1): $(filter-out $(addsuffix .o,$(value $(1)_EXCL)), $(OBJS))  
	$(CC) -o $(1) $(filter-out $(addsuffix .o, $(value $(addsuffix _EXCL, $(1)))), $(OBJS)) $(LIBS) $(value $(addsuffix _LIBS, $(1)))  
endef  
  
define CMPL_SRC  
${1}.o:  
	${CC} $(CFLAGS) ${1} -o ${1}.o  
endef  
  
.PHONY: all clean  
.SUFFIXES:  
  
all: $(APP)  
$(foreach s,$(SRCS),$(eval $(call CMPL_SRC, $(s))))  
$(foreach ap,$(APP),$(eval $(call CMPL_APP, $(ap))))  

clean:  
	rm -f ${OBJS} ${value APP}
