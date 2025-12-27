let colors = ["aqua", "orange", "lime", "fuchsia", "gold"];
let index = 0;

function set_primary_color(root, button) {
	index++;
	if (index >= colors.length) index = 0;
	let new_color = colors[index];
	root.style.setProperty('--primary-color', new_color);
	button.innerHTML = new_color;

}

window.addEventListener('DOMContentLoaded', (event) => {
    console.log('DOM is fully loaded and parsed');
    // Your code to interact with static DOM elements goes here

	let button = document.querySelector('#button-color');
	let root = document.querySelector(':root');

	button.addEventListener('click', () => {
		set_primary_color(root, button);
    });
});

