FROM debian:latest
MAINTAINER Zugg

RUN echo "deb http://www.deb-multimedia.org wheezy main non-free" >> /etc/apt/sources.list
RUN echo "deb-src http://www.deb-multimedia.org wheezy main non-free" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y --force-yes deb-multimedia-keyring
RUN apt-get update

RUN apt-get install -y build-essential git python-pip python-virtualenv libssl-dev libvpx-dev make nasm pkg-config libx264-dev libxext-dev libxfixes-dev zlib1g-dev yasm libfaac-dev libfaad-dev faad faac libfaac0 libmp3lame-dev x264 libxvidcore-dev checkinstall libgsm-tools libgsm1 libgsm1-dev libopencore-amrnb-dev libopencore-amrwb-dev libopenjpeg-dev libschroedinger-dev speex libspeex-dev libtheora-dev autoconf automake libass-dev libfreetype6-dev libgpac-dev libsdl1.2-dev libtool libva-dev libvdpau-dev libvorbis-dev libx11-dev texi2html wget libdc1394-22 libdc1394-22-dev
RUN virtualenv ~/.cbenv
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN git clone https://github.com/zugg/CaptureBate /root/capturebate

RUN git clone --depth=1 git://source.ffmpeg.org/ffmpeg.git ~/ffmpeg

RUN cd ~/ffmpeg && ./configure --enable-gpl --enable-version3 --enable-nonfree --enable-postproc --enable-x11grab --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libdc1394 --enable-libfaac --enable-libgsm --enable-libmp3lame --enable-libopenjpeg --enable-libschroedinger --enable-libspeex --enable-libtheora --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libxvid && make && make install

RUN source ~/.cbenv/bin/activate

RUN cd ~/capturebate && pip install -r requirements.txt
