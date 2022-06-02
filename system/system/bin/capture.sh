#!/system/bin/sh

function enable_ultracapture()
{
printf "打开MIC通路++\n"
tinymix 'TX DEC0 MUX' 'SWR_MIC'
tinymix 'ADC2 ChMap' 'SWRM_TX2_CH1'
tinymix 'TX SMIC MUX0' 'SWR_MIC4'
tinymix 'TX_CDC_DMA_TX_3 Channels' 'One'
tinymix 'TX_AIF1_CAP Mixer DEC0' '1'
tinymix 'ADC2_MIXER Switch' '1'
tinymix 'ADC2 MUX' 'INP3'
tinymix 'TX_CDC_DMA_TX_3 SampleRate' 'KHZ_96'
tinymix 'MultiMedia1 Mixer TX_CDC_DMA_TX_3' '1'

tinycap /sdcard/us_mic.wav -D 0 -d 0 -r $1 -b $2 -c $3 -T $4
printf "录音结束\n"
}

function disable_ultracapture
{
printf "关闭MIC通路++\n"
tinymix 'TX DEC0 MUX' 'MSM_DMIC'
tinymix 'ADC2 ChMap' 'ZERO'
tinymix 'TX SMIC MUX0' 'ZERO'
tinymix 'TX_CDC_DMA_TX_3 Channels' 'One'
tinymix 'TX_AIF1_CAP Mixer DEC0' '0'
tinymix 'ADC2_MIXER Switch' '0'
tinymix 'ADC2 MUX' 'INP2'
tinymix 'MultiMedia1 Mixer TX_CDC_DMA_TX_3' '0'
tinymix 'TX_CDC_DMA_TX_3 SampleRate' 'KHZ_48'
}

if test -z $1
then
printf "输入参数格式：capture.sh 96000(SampleRate) 16(SampleBit) 2(SampleChannel) 6(Time:s)\n"
else

enable_ultracapture $1 $2 $3 $4
disable_ultracapture

fi
