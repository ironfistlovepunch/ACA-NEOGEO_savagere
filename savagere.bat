REM savagere
REM SROM
copy 294C59 059-s1.s1
copy /b 059-s1.s1+

REM MROM PROM
romcutter 1E5508 m1.bin 0 20000

romcutter 1E5508 p1_1 20000 100000
romcutter 1E5508 p1_2 120000 100000

copy /b p1_2 + p1_1 059-p1.p1

REM PROM
REM romcutter 1F33BC 059-p1_2.p1 0 200000
REM romcutter 1F33BC 059-p2.sp2 200000 100000

REM VROM
romcutter 9E8690 059-v1.v1 0 200000
romcutter 9E8690 059-v2.v2 200000 200000
romcutter 9E8690 059-v3.v3 400000 200000

REM CROM
copy /b 2E9760+497DA8+67AAC8+85DE60 crom
romcutter crom c1c2 0 400000
romcutter crom c3c4 400000 400000
romcutter crom c5c6 800000 400000
romcutter crom c7c8 C00000 400000

BSwap.exe d B c1c2 oddeven.txt 059-c1.c1 059-c2.c2
BSwap.exe d B c3c4 oddeven.txt 059-c3.c3 059-c4.c4
BSwap.exe d B c5c6 oddeven.txt 059-c5.c5 059-c6.c6
BSwap.exe d B c7c8 oddeven.txt 059-c7.c7 059-c8.c8

REM forcecrc
copy m1.bin 059-m1.m1
forcecrc32.py 059-m1.m1 20 29992EBA 

REM delete
del c1c2 c3c4 c5c6 c7c8
del crom
del p1_1 p1_2
del m1.bin

REM compress
powershell Compress-Archive 059*.* -Force -DestinationPath savagere.zip

copy savagere.zip romcenter