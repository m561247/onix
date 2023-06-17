USB_BIN:= 
USB_DEV:= /dev/sdb

.PHONY: usb
usb: $(USB_DEV) $(BUILD)/master.img
	sudo dd if=/dev/sdb of=$(BUILD)/usb.bin bs=512 count=1 conv=notrunc
	sudo chown $(USER) $(BUILD)/usb.bin

	dd if=$(BUILD)/master.img of=$(BUILD)/usb.bin bs=446 count=1 conv=notrunc

	cp $(BUILD)/master.img $(BUILD)/usb.img
	dd if=$(BUILD)/usb.bin of=$(BUILD)/usb.img bs=512 count=1 conv=notrunc

	sudo dd if=$(BUILD)/usb.img of=/dev/sdb bs=1 count=$$(stat -c%s "$(BUILD)/master.img") conv=notrunc
