// set dark background color
document.body.parentElement.style.backgroundColor = "#333";

// enable dark mode
if (!document.querySelector('body').classList.contains('dark')) {
    document.querySelector('body').classList.add('dark');
}
