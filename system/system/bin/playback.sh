#!/system/bin/sh
function enable_playback()
{
echo "open receiver++\n"
if [ -e "/dev/fs19xx" ];then
	tinymix "SEC_MI2S_RX SampleRate" KHZ_96
	tinymix 'FSM_Scene' '15'
	tinymix 'FSM_Volume' '230'
	echo "dev node: fs19xx"
else
	tinymix 'aw_dev_1_switch' 'Enable'
	echo "dev node: awinic smartpa"
fi
tinymix 'SEC_MI2S_RX Audio Mixer MultiMedia1' '1'
}
function disable_playback
{
echo "close receiver++\n"
if [ -e "/dev/fs19xx" ];then
	tinymix "SEC_MI2S_RX SampleRate" KHZ_48
	tinymix 'FSM_Scene' '0'
	tinymix 'FSM_Volume' '255'
	echo "dev node: fs19xx end"
else
	tinymix 'aw_dev_1_switch' 'Disable'
	echo "dev node: awinic smartpa end"
fi
tinymix 'SEC_MI2S_RX Audio Mixer MultiMedia1' '0'
}
enable_playback
echo "start playing\n"
tinyplay /vendor/etc/mmigroup/ultrasound.wav
disable_playback
