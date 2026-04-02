let colors = ["aqua", "orange", "lime"];
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
		
	} else { console.log("Local storage not supported."); }
}

function next_index() {
	index++;
	if (index >= colors.length) index = 0;
	save_index(index);
}

function change_color(root, main_title) {
	next_index();
	root.style.setProperty('--primary-color', colors[index]);
	main_title.innerHTML = colors[index]+"-time";
}

window.addEventListener('DOMContentLoaded', (event) => {
    let main_title = document.querySelector('.main-header').getElementsByTagName('h1')[0];
    let portrait = document.getElementById('portrait');
	let root = document.querySelector(':root');

	update_index_from_storage();
	root.style.setProperty('--primary-color', colors[index]);

    if (main_title && portrait) {
        portrait.addEventListener('click', () => change_color(root, main_title))
    }
});
