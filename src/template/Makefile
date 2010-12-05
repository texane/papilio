# xilinx spartan3e template makefile

# spartan model
# MODEL=xc3s250e-4-vq100
MODEL := xc3s500e-4-vq100

# xilinx binraries directory
ISE_BINDIR := /opt/Xilinx/12.3/ISE_DS/ISE/bin/lin

# papiolo loader directory
PAPILIO_BINDIR := $(HOME)/install/bin

# project name
NAME := main

# user constraints file
UCF := papilio.ucf

# project source files
SRCS := main.v

# temporary files
TMP := $(NAME).

# make rules
all: $(NAME).bit

%.bit: %-routed.ncd
	$(ISE_BINDIR)/bitgen -w -g StartUpClk:CClk -g CRC:Enable $< $@

$(NAME).prj: $(SRCS)
	@-rm $(NAME).prj 2> /dev/null ;
	@for i in $(SRCS); do echo "verilog work $$i" >> $(NAME).prj; done

$(NAME).xst: $(NAME).prj
	@-rm $(NAME).xst 2> /dev/null ;
	@echo run >> $(NAME).xst
	@echo -ifn $(NAME).prj >> $(NAME).xst
	@echo -top counter >> $(NAME).xst
	@echo -ifmt MIXED >> $(NAME).xst
	@echo -ofn $(NAME) >> $(NAME).xst
	@echo -ofmt NGC >> $(NAME).xst
	@echo -p $(MODEL) >> $(NAME).xst
	@echo -opt_mode Speed >> $(NAME).xst
	@echo -opt_level 1 >> $(NAME).xst

%-routed.ncd: %.ncd
	@$(ISE_BINDIR)/par -w $< $@

%.ncd: %.ngd
	@$(ISE_BINDIR)/map -p $(MODEL) -detail -pr off -o $@ $<

%.ngc: $(NAME).xst
	@$(ISE_BINDIR)/xst -ifn $< -ofn $@

%.ngd: %.ngc $(UCF)
	@$(ISE_BINDIR)/ngdbuild -uc $(UCF) -p $(MODEL) $< $@

.PHONY: write # clean fclean

write:	$(NAME).bit
	@sudo $(PAPILIO_BINDIR)/papilioloader -f $(NAME).bit
