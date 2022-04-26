// set dark background color
document.body.parentElement.style.backgroundColor = "#fcfcfc";

// disable dark mode
if (document.querySelector('body').classList.contains('dark')) {
    document.querySelector('body').classList.remove('dark');
}
