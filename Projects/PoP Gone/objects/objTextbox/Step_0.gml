state.step();
image_xscale	= flerp(		image_xscale,	scale.x, 0.17, 0.07);
image_yscale	= flerp(		image_yscale,	scale.y, 0.17, 0.07);
image_blend		= merge_color(	image_blend,	blend.x, 0.2);
image_alpha		= flerp(		image_alpha,	blend.y, 0.2);

texAlpha = showText ? approach(texAlpha, 1, 0.1) : approach(texAlpha, 0, 0.1);