# search for image in video
ffmpeg  -i input_file.vid -r 1 -loop 1 -i input_img.jpg -an -filter_complex "blend=difference:shortest=1,blackframe=99:32" -f null - 2>&1

# Basic rewrap command
ffmpeg -i input_file.ext -c copy -map 0 output_file.ext
# Rewrap DV video to .dv file
ffmpeg -i input_file -f rawvideo -c:v copy output_file.dv
# Transcode to deinterlaced Apple ProRes LT
ffmpeg -i input_file -c:v prores -profile:v 1 -vf yadif -c:a pcm_s16le output_file.mov
# Transcode to an H.264 access file
ffmpeg -i input_file -c:v libx264 -pix_fmt yuv420p -c:a aac output_file
# Transcode from DCP to an H.264 access file
ffmpeg -i input_video_file.mxf -i input_audio_file.mxf -c:v libx264 -pix_fmt yuv420p -c:a aac output_file.mp4
# Transcode your file with the FFV1 Version 3 Codec in a Matroska container
ffmpeg -i input_file -map 0 -dn -c:v ffv1 -level 3 -g 1 -slicecrc 1 -slices 16 -c:a copy output_file.mkv -f framemd5 -an framemd5_output_file
# Convert DVD to H.264
ffmpeg -i concat:input_file_1\|input_file_2\|input_file_3 -c:v libx264 -c:a aac output_file.mp4
# Transcode to an H.265/HEVC MP4
ffmpeg -i input_file -c:v libx265 -pix_fmt yuv420p -c:a copy output_file
# Transcode to an Ogg Theora
ffmpeg -i input_file -acodec libvorbis -b:v 690k output_file
# Convert WAV to MP3
ffmpeg -i input_file.wav -write_id3v1 1 -id3v2_version 3 -dither_method rectangular -out_sample_rate 48k -qscale:a 1 output_file.mp3
# Generate two access MP3s (with and without copyright).
ffmpeg -i input_file -i input_file_to_append -filter_complex "[0:a:0]asplit=2[a][b];[b]afifo[bb];[1:a:0][bb]concat=n=2:v=0:a=1[concatout]" -map "[a]" -codec:a libmp3lame -dither_method modified_e_weighted -qscale:a 2 output_file.mp3 -map "[concatout]" -codec:a libmp3lame -dither_method modified_e_weighted -qscale:a 2 output_file_appended.mp3
# Convert WAV to AAC/MP4
ffmpeg -i input_file.wav -c:a aac -b:a 128k -dither_method rectangular -ar 44100 output_file.mp4
# Transform 4:3 aspect ratio into 16:9 with pillarbox
ffmpeg -i input_file -filter:v "pad=ih*16/9:ih:(ow-iw)/2:(oh-ih)/2" -c:a copy output_file
# Transform 16:9 aspect ratio video into 4:3 with letterbox
ffmpeg -i input_file -filter:v "pad=iw:iw*3/4:(ow-iw)/2:(oh-ih)/2" -c:a copy output_file
# Flip video image
ffmpeg -i input_file -filter:v "hflip,vflip" -c:a copy output_file
# Transform SD to HD with pillarbox
ffmpeg -i input_file -filter:v "colormatrix=bt601:bt709, scale=1440:1080:flags=lanczos, pad=1920:1080:240:0" -c:a copy output_file
# Change display aspect ratio without re-encoding
ffmpeg -i input_file -c:v copy -aspect 4:3 output_file
# Convert colorspace of video
ffmpeg -i input_file -c:v libx264 -vf colormatrix=src:dst output_file
# Modify image and sound speed
ffmpeg -i input_file -r output_fps -filter_complex "[0:v]setpts=input_fps/output_fps*PTS[v]; [0:a]atempo=output_fps/input_fps[a]" -map "[v]" -map "[a]" output_file
# Synchronize video and audio streams
ffmpeg -i input_file -itsoffset 0.125 -i input_file -map 1:v -map 0:a -c copy output_file
# Clarify stream properties
ffprobe input_file -show_streams
# Crop video
ffmpeg -i input_file -vf "crop=width:height" output_file
# Change video color to black and white
ffmpeg -i input_file -filter_complex hue=s=0 -c:a copy output_file
# Extract audio without loss from an AV file
ffmpeg -i input_file -c:a copy -vn output_file
# Combine audio tracks
ffmpeg -i input_file -filter_complex "[0:a:0][0:a:1]amerge[out]" -map 0:v -map "[out]" -c:v copy -shortest output_file
# Inverses the audio phase of the second channel
ffmpeg -i input_file -af pan="stereo|c0=c0|c1=-1*c1" output_file
# Calculate Loudness Levels
ffmpeg -i input_file -af loudnorm=print_format=json -f null -
# RIAA Equalization
ffmpeg -i input_file -af aemphasis=type=riaa output_file
# Reverse CD Pre-Emphasis
ffmpeg -i input_file -af aemphasis=type=cd output_file
# One Pass Loudness Normalization
ffmpeg -i input_file -af loudnorm=dual_mono=true -ar 48k output_file
# Two Pass Loudness Normalization
ffmpeg -i input_file -af loudnorm=dual_mono=true:measured_I=input_i:measured_TP=input_tp:measured_LRA=input_lra:measured_thresh=input_thresh:offset=target_offset:linear=true -ar 48k output_file
# Fix A/V sync issues by resampling audio
ffmpeg -i input_file -c:v copy -c:a pcm_s16le -af "aresample=async=1000" output_file
# Join (concatenate) two or more files of the same type
ffmpeg -f concat -i mylist.txt -c copy output_file
# Join (concatenate) two or more files of different types
ffmpeg -i input_1.avi -i input_2.mp4 -filter_complex "[0:v:0][0:a:0][1:v:0][1:a:0]concat=n=2:v=1:a=1[video_out][audio_out]" -map "[video_out]" -map "[audio_out]" output_file
# Split one file into several smaller segments
ffmpeg -i input_file -c copy -map 0 -f segment -segment_time 60 -reset_timestamps 1 output_file-%03d.mkv
# Trim file
ffmpeg -i input_file -ss 00:02:00 -to 00:55:00 -c copy -map 0 output_file
# Create an excerpt, starting from the beginning of the file
ffmpeg -i input_file -t 5 -c copy -map 0 output_file
# Create a new file with the first five seconds trimmed off the original
ffmpeg -i input_file -ss 5 -c copy -map 0 output_file
# Create a new file with the final five seconds of the original
ffmpeg -sseof -5 -i input_file -c copy -map 0 output_file
# Trim silence from beginning of an audio file
ffmpeg -i input_file -af silenceremove=start_threshold=-57dB:start_duration=1:start_periods=1  -c:a your_codec_choice -ar your_sample_rate_choice output_file
# Trim silence from the end of an audio file
ffmpeg -i input_file -af areverse,silenceremove=start_threshold=-57dB:start_duration=1:start_periods=1,areverse -c:a your_codec_choice -ar your_sample_rate_choice output_file
# Upscaled, pillar-boxed HD H.264 access files from SD NTSC source
ffmpeg -i input_file -c:v libx264 -filter:v "yadif, scale=1440:1080:flags=lanczos, pad=1920:1080:(ow-iw)/2:(oh-ih)/2, format=yuv420p" output_file
# Deinterlace video
ffmpeg -i input_file -c:v libx264 -vf "yadif,format=yuv420p" output_file
# Inverse telecine
ffmpeg -i input_file -c:v libx264 -vf "fieldmatch,yadif,decimate" output_file
# Set field order for interlaced video
ffmpeg -i input_file -c:v video_codec -filter:v setfield=tff output_file
# Identify interlacement patterns in a video file
ffmpeg -i input file -filter:v idet -f null -
# Create opaque centered text watermark
ffmpeg -i input_file -vf drawtext="fontfile=font_path:fontsize=font_size:text=watermark_text:fontcolor=font_color:alpha=0.4:x=(w-text_w)/2:y=(h-text_h)/2" output_file
# Overlay image watermark on video
ffmpeg -i input_video file -i input_image_file -filter_complex overlay=main_w-overlay_w-5:5 output_file
# Burn in timecode
ffmpeg -i input_file -vf drawtext="fontfile=font_path:fontsize=font_size:timecode=starting_timecode:fontcolor=font_colour:box=1:boxcolor=box_colour:rate=timecode_rate:x=(w-text_w)/2:y=h/1.2" output_file
Embed subtitles
ffmpeg -i input_file -i subtitles_file -c copy -c:s mov_text output_file
# Export one thumbnail per video file
ffmpeg -i input_file -ss 00:00:20 -vframes 1 thumb.png
# Export many thumbnails per video file
ffmpeg -i input_file -vf fps=1/60 out%d.png
# Create GIF from still images
ffmpeg -f image2 -framerate 9 -pattern_type glob -i "input_image_*.jpg" -vf scale=250x250 output_file.gif
# Create GIF from a video
ffmpeg -ss HH:MM:SS -i input_file -filter_complex "fps=10,scale=500:-1:flags=lanczos,palettegen" -t 3 palette.png
ffmpeg -ss HH:MM:SS -i input_file -i palette.png -filter_complex "[0:v]fps=10, scale=500:-1:flags=lanczos[v], [v][1:v]paletteuse" -t 3 -loop 6 output_file
# Transcode an image sequence into uncompressed 10-bit video
ffmpeg -f image2 -framerate 24 -i input_file_%06d.ext -c:v v210 output_file
# Create video from image and audio
ffmpeg -r 1 -loop 1 -i image_file -i audio_file -acodec copy -shortest -vf scale=1280:720 output_file
# Audio Bitscope
ffplay -f lavfi "amovie=input_file, asplit=2[out1][a], [a]abitscope=colors=purple|yellow[out0]"
# Play a graphical output showing decibel levels of an input file
ffplay -f lavfi "amovie='input.mp3', astats=metadata=1:reset=1, adrawgraph=lavfi.astats.Overall.Peak_level:max=0:min=-30.0:size=700x256:bg=Black[out]"
# Identify pixels out of broadcast range
ffplay -f lavfi "movie='input.mp4', signalstats=out=brng:color=cyan[out]"
# Vectorscope from video to screen
ffplay input_file -vf "split=2[m][v], [v]vectorscope=b=0.7:m=color3:g=green[v], [m][v]overlay=x=W-w:y=H-h"
# Side by Side Videos/Temporal Difference Filter
ffmpeg -i input01 -i input02 -filter_complex "[0:v:0]tblend=all_mode=difference128[a];[1:v:0]tblend=all_mode=difference128[b];[a][b]hstack[out]" -map [out] -f nut -c:v rawvideo - | ffplay -
# Use xstack to arrange output layout of multiple video sources
ffplay -f lavfi -i testsrc -vf "split=3[a][b][c],[a][b][c]xstack=inputs=3:layout=0_0|0_h0|0_h0+h1[out]"
# Pull specs from video file
ffprobe -i input_file -show_format -show_streams -show_data -print_format xml
# Strip metadata
ffmpeg -i input_file -map_metadata -1 -c:v copy -c:a copy output_file
# Batch processing (Mac/Linux)
for file in *.mxf; do ffmpeg -i "$file" -map 0 -c copy "${file%.mxf}.mov"; done
# Check decoder errors
ffmpeg -i input_file -f null -
# Check FFV1 fixity
ffmpeg -report -i input_file -f null -
# Create MD5 checksums (video frames)
ffmpeg -i input_file -f framemd5 -an output_file
# Create MD5 checksums (audio samples)
ffmpeg -i input_file -af "asetnsamples=n=48000" -f framemd5 -vn output_file
# Create MD5 checksum(s) for A/V stream data only
ffmpeg -i input_file -map 0:v:0 -c:v copy -f md5 output_file_1 -map 0:a:0 -c:a copy -f md5 output_file_2
# Get checksum for video/audio stream
ffmpeg -loglevel error -i input_file -map 0:v:0 -f hash -hash md5 -
# QCTools report (with audio)
ffprobe -f lavfi -i "movie=input_file:s=v+a[in0][in1], [in0]signalstats=stat=tout+vrep+brng, cropdetect=reset=1:round=1, idet=half_life=1, split[a][b];[a]field=top[a1];[b]field=bottom, split[b1][b2];[a1][b1]psnr[c1];[c1][b2]ssim[out0];[in1]ebur128=metadata=1, astats=metadata=1:reset=1:length=0.4[out1]" -show_frames -show_versions -of xml=x=1:q=1 -noprivate | gzip > input_file.qctools.xml.gz
# QCTools report (no audio)
ffprobe -f lavfi -i "movie=input_file,signalstats=stat=tout+vrep+brng, cropdetect=reset=1:round=1, idet=half_life=1, split[a][b];[a]field=top[a1];[b]field=bottom,split[b1][b2];[a1][b1]psnr[c1];[c1][b2]ssim" -show_frames -show_versions -of xml=x=1:q=1 -noprivate | gzip > input_file.qctools.xml.gz
# Read/Extract EIA-608 Closed Captioning
ffprobe -f lavfi -i movie=input_file,readeia608 -show_entries frame=pkt_pts_time:frame_tags=lavfi.readeia608.0.line,lavfi.readeia608.0.cc,lavfi.readeia608.1.line,lavfi.readeia608.1.cc -of csv > input_file.csv
# Make a mandelbrot test pattern video
ffmpeg -f lavfi -i mandelbrot=size=1280x720:rate=25 -c:v libx264 -t 10 output_file
# Make a SMPTE bars test pattern video
ffmpeg -f lavfi -i smptebars=size=720x576:rate=25 -c:v prores -t 10 output_file
# Make a test pattern video
ffmpeg -f lavfi -i testsrc=size=720x576:rate=25 -c:v v210 -t 10 output_file
# Play HD SMPTE bars
ffplay -f lavfi -i smptehdbars=size=1920x1080
# Play VGA SMPTE bars
ffplay -f lavfi -i smptebars=size=640x480
# Generate a sine wave test audio file
ffmpeg -f lavfi -i "sine=frequency=1000:sample_rate=48000:duration=5" -c:a pcm_s16le output_file.wav
# SMPTE bars + Sine wave audio
ffmpeg -f lavfi -i "smptebars=size=720x576:rate=25" -f lavfi -i "sine=frequency=1000:sample_rate=48000" -c:a pcm_s16le -t 10 -c:v ffv1 output_file
# Make a broken file
ffmpeg -i input_file -bsf noise=1 -c copy output_file
# Conway's Game of Life
ffplay -f lavfi life=s=300x200:mold=10:r=60:ratio=0.1:death_color=#C83232:life_color=#00ff00,scale=1200:800
# Play video with OCR
ffplay input_file -vf "ocr,drawtext=fontfile=/Library/Fonts/Andale Mono.ttf:text=%{metadata\\\:lavfi.ocr.text}:fontcolor=white"
# Export OCR from video to screen
ffprobe -show_entries frame_tags=lavfi.ocr.text -f lavfi -i "movie=input_file,ocr"
# Compare Video Fingerprints
ffmpeg -i input_one -i input_two -filter_complex signature=detectmode=full:nb_inputs=2 -f null -
# Generate Video Fingerprint
ffmpeg -i input -vf signature=format=xml:filename="output.xml" -an -f null -
# Play an image sequence
ffplay -framerate 5 input_file_%06d.ext
# Split audio and video tracks
ffmpeg -i input_file -map 0:v:0 video_output_file -map 0:a:0 audio_output_file
# Merge audio and video tracks
ffmpeg -i video_file -i audio_file -map 0:v -map 1:a -c copy output_file
# Create ISO files for DVD access
ffmpeg -i input_file -aspect 4:3 -target ntsc-dvd output_file.mpg
# CSV with timecodes and YDIF
ffprobe -f lavfi -i movie=input_file,signalstats -show_entries frame=pkt_pts_time:frame_tags=lavfi.signalstats.YDIF -of csv
# Cover head switching noise
ffmpeg -i input_file -filter:v drawbox=w=iw:h=7:y=ih-h:t=max output_file
# Record and live-stream simultaneously
ffmpeg -re -i ${INPUTFILE} -map 0 -flags +global_header -vf scale="1280:-1,format=yuv420p" -pix_fmt yuv420p -level 3.1 -vsync passthrough -crf 26 -g 50 -bufsize 3500k -maxrate 1800k -c:v libx264 -c:a aac -b:a 128000 -r:a 44100 -ac 2 -t ${STREAMDURATION} -f tee "[movflags=+faststart]${TARGETFILE}|[f=flv]${STREAMTARGET}"
# View FFmpeg subprogram information
ffmpeg -h type=name
# Rip a CD with CD Paranoia
cdparanoia -L -B -O [Drive Offset] [Starting Track Number]-[Ending Track Number] output_file.wav
# Rip a CD with Cdda2wav
cdda2wav -L0 -t all -cuefile -paranoia paraopts=retries=200,readahead=600,minoverlap=sectors-per-request-1 -verbose-level all output.wav
# Compare two images
compare -metric ae image1.ext image2.ext null:
# Create thumbnails of images
mogrify -resize 80x80 -format jpg -quality 75 -path thumbs *.jpg
# Creates grid of images from text file
montage @list.txt -tile 6x12 -geometry +0+0 output_grid.jpg
# Get file signature data
convert -verbose input_file.ext | grep -i signature
# Removes exif metadata
mogrify -path ./stripped/ -strip *.jpg
# Resizes image to specific pixel width
convert input_file.ext -resize 750 output_file.ext
# Transcoding to/from FLAC
flac --best --keep-foreign-metadata --preserve-modtime --verify input.wav
flac --decode --keep-foreign-metadata --preserve-modtime --verify input.flac
