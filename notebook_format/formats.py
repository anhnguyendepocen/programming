import json
import warnings
import matplotlib.pyplot as plt
from IPython.core.display import HTML

def load_style(css_style = 'custom1.css'):
	"""
	custom1.css adapted from
	https://github.com/rlabbe/ThinkBayes/blob/master/code/custom.css

	custom2.css adapted from
	https://github.com/neilpanchal/iPython-Notebook-Theme
	"""

	# recent matplotlibs are raising deprecation warnings that
	# we don't worry about (it's the axes_prop_cycle).
	warnings.filterwarnings('ignore')

	# update the default matplotlib's formating
	with open('plot.json') as f:
		s = json.load(f)
	plt.rcParams.update(s)

	# load the styles for the notebooks
	with open(css_style) as f:
		styles = f.read()
	return HTML(styles)

