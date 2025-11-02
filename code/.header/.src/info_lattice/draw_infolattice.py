#!/usr/bin/env python3
import matplotlib.pyplot as plt
import matplotlib.patches
import numpy as np

def draw_infolattice(ax, infolattice,cmap=matplotlib.colormaps['viridis']):

    cm=cmap

    ax.set_aspect(1)
    a=np.array([1,0])
    b=np.array([0.5,np.sqrt(3)/2.])

    ax.set_xlim(-1,len(infolattice[0]))
    ax.set_ylim(-1,len(infolattice)-0.5)

    for nb, line in enumerate(infolattice):
        for na, val in enumerate(line):
            coord = na*a+nb*b
            artist_ = matplotlib.patches.RegularPolygon(coord, 6, radius=0.55, color=cm(val))
            ax.add_artist(artist_)




infolatt=[[0,0.1,0,0,0.1,0.2],[0.1,0.9,0.1,0.3,0.4],[0.2,0.2,0.1,0.3],[0.1,0.2,0.3],[0.8,0.2],[0.1]]

    
plt.figure()
ax=plt.gca()
draw_infolattice(ax, infolatt)
plt.savefig("infolattice.png")
