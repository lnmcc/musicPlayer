TARGET = player


CROSS_COMPILE =

#####################################
AS              = $(CROSS_COMPILE)as
LD              = $(CROSS_COMPILE)ld
CC              = $(CROSS_COMPILE)gcc
CPP             = $(CC) -E
AR              = $(CROSS_COMPILE)ar
NM              = $(CROSS_COMPILE)nm
STRIP           = $(CROSS_COMPILE)strip
OBJCOPY         = $(CROSS_COMPILE)objcopy
OBJDUMP         = $(CROSS_COMPILE)objdump
LN				= ln -f
CHMOD			= chmod

CFLAGS += -I. -I/usr/local/include -g -Wall  -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_ISOC9X_SOURCE -std=c99

LDFLAGS += -lavdevice  -lswresample -lavformat -lavcodec -lavutil -lswscale -lGLU -lGL -lm -lz -lpthread -lX11 -lSDL

SRC=$(wildcard *.c)
OBJS=${SRC:%.c=%.o}
NAME=${SRC:%.c=%}
DEPS=$(SRC:%.c=.dep/%.d)

.PHONY: dep  all

all: $(OBJS)
	$(CC) -o $(TARGET) $(OBJS) $(LDFLAGS) 
#	$(STRIP) $(TARGET)


clean:
	rm -rf *.o $(TARGET) .dep

%.o: %.c
	${CC} ${CFLAGS} -c $<
	@mkdir -p .dep
	${CC} -MM $(CFLAGS) $*.c > .dep/$*.d 


dep: 
	@mkdir -p .dep
	for i in ${NAME} ; do  \
		${CC} -MM $(CFLAGS) "$${i}".c > .dep/"$${i}".d ;\
	done

