bin = ../../cngf-pf/cngf-pf

output_interval = 1.0
end_time = 300.0
shear_vel = 0.01
thickness = 1.0

common_arg = -T \
	-y 0.20 -Y 0.5 -K 4.0 -n 17049\
	-I $(output_interval) -e $(end_time) \
	-L $(thickness) -s $(shear_vel)

PF_SEQ=  0.2104 0.2105  0.2106 0.2107 0.2108 0.2109 0.211 0.2111 0.2112 0.2113

default: example.pdf

.SUFFIXES: .log .pdf
example.pdf: fig.gp time-series.txt
	gnuplot -e  "\
		file_dt=$(output_interval); \
		shear_vel=$(shear_vel); \
		thickness=$(thickness);" \
		fig.gp > $@

.SUFFIXES: .output00000.txt .log
.output00000.txt.log:
	v="$<"; \
	for f in $${v%%output*}output*.txt; do \
		tail -1 "$$f"; \
	done > $@

porosity-1.output00000.txt: #$(bin) Makefile
	rm -f porosity-*.output*.txt
	/bin/sh -c 'for i in $(PF_SEQ); do \
	$(bin) \
		-p $${i}\
		$(common_arg) \
		porosity-$$i; done'

time-series.txt: porosity-1.output00000.txt
	/bin/sh -c '\
	rm -f $@; \
	for i in $(PF_SEQ); do \
		for f in porosity-$$i.output*.txt; do \
			tail -n 1 "$$f" | cut -f 2,5,7,8 >> time-series-$$i.txt; \
	done; done'
	rm -f porosity-*.output*.txt

overconsolidated.output00000.txt: #$(bin) Makefile
	rm -f overconsolidated.output*.txt
	$(bin) \
		-p 0.201  -n 1e3 \
		$(common_arg) \
		overconsolidated >/dev/null

clean:
	rm -f *.txt
	rm -f *.log
	rm -f *.pdf

.PHONY: default clean
