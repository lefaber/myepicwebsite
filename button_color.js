let colors = ["aqua", "orange", "lime", "fuchsia", "gold"];
let index = 0;
const key = "primary_color_index";
const storage_is_supported = typeof(Storage) !== "undefined";

function save_index(index) {
	if (storage_is_supported) localStorage.setItem(key, index);
	else console.log("Local storage not supported.");
}

function update_index_from_storage() {
	if (storage_is_supported) {
		let saved_index = localStorage.getItem(key);
		if (saved_index) {
			index = saved_index;
		} else {
			console.log("Setting default primary_color");
			save_index(0);
		}
		
	} else {
		console.log("Local storage not supported.");
	}
}

function next_index() {
	index++;
	if (index >= colors.length) index = 0;
	save_index(index);
}

function update_color(root, button) {
	root.style.setProperty('--primary-color', colors[index]);
	button.innerHTML = colors[index];
}

function change_color(root, button) {
	next_index();
	update_color(root, button);
}

function set_saved_color(root, button) {
	update_index_from_storage();
	update_color(root, button);
}

window.addEventListener('DOMContentLoaded', (event) => {
	let button = document.querySelector('#button-color');
	let root = document.querySelector(':root');

	set_saved_color(root, button);

	button.addEventListener('click', () => change_color(root, button));
});

