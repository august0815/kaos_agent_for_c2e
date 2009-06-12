define velx(agent a) returning numeric {
	_caos {
		.targ < $a {
			.inline let $return = VELX;
		};
	};
}



install {
	print(velx(norn()));
}
