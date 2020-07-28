
import numpy as np
from numpy import pi, inf, NaN
from deerlab import correctzerotime
from deerlab.dd_models import dd_gauss,dd_gauss3
from deerlab.utils import ovl

def test_correction():
#=======================================================================
    "Check that the time-axis is corrected apropiately"

    t_truth = np.arange(-5,80,0.5)
    y = 3000 - t_truth**2
    y = y/max(y)
    t = t_truth + abs(min(t_truth))

    t_corr,_ = correctzerotime(y,t)

    assert max(abs(t_corr - t_truth)) < 1e-10
#=======================================================================

test_correction()
def test_zerotime():
#=======================================================================
    "Check that the zerotime of a simple function is found correctly"
        

    t_truth = np.arange(-5,80,0.5)
    y = 3000 - t_truth**2
    y = y/max(y)
    t = t_truth + abs(min(t_truth))
    t0_truth = abs(min(t_truth))
    
    _,t0_found = correctzerotime(y,t)

    assert abs(t0_found - t0_truth) < 1e-10
#=======================================================================


def test_late_times():
#=======================================================================
    "Check that zero-time correction works when maximum is at later times"

    
    t_truth = np.linspace(-5,1,400)
    y = 10 - t_truth**2
    y = y/max(y)
    tshift = 1.2343

    t = t_truth + tshift

    t_corr,_ = correctzerotime(y,t)

    assert max(abs(t_corr - t_truth)) < 1e-10
#=======================================================================