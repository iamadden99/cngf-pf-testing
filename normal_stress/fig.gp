set terminal pdfcairo color size 15 cm, 20 cm font ",10"
set multiplot layout 3,1 \
	spacing 0.04,0.04

unset xtics

xmult = file_dt * shear_vel / thickness

#set ylabel "shear velocity"
filelist = system("ls -1 time-series-*.txt")
labels = system("ls -1 time-series-*.txt | sed -e 's/time-series-//' -e 's/.txt//'")
#plot for [f in filelist] f u ($0*xmult):1 w l title f

set ylabel "friction"
plot for [i=1:words(filelist)] word(filelist, i) u ($0*xmult):2 w l title word(labels, i) noenhanced

set ylabel "porosity"
plot for [i=1:words(filelist)] word(filelist, i) u ($0*xmult):3 w l title word(labels, i) noenhanced

set xlabel "Shear strain [-]"
set xtics

set ylabel "I"
plot for [i=1:words(filelist)] word(filelist, i) u ($0*xmult):4 w l title word(labels, i) noenhanced
