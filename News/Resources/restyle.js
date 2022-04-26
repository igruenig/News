// apply custom style
const styleElement = document.createElement('style');
styleElement.innerHTML = `
html, body, .post-content {
    font-family: -apple-system;
}
.dark, .dark a {
    color: #ddd;
}
.dark code {
    background-color: #444;
}
.dark pre code {
    background-color: #f0f0f0;
}
.dark .home .post-link {
    color: #bdcee5;
}
.dark .site-header {
    background-color: #333;
    border-bottom: 1px solid #555;
}
.dark .site-header a {
    color: #888;
}
.dark a:visited {
    color: #666;
}
`;
document.head.appendChild(styleElement);

// remove site navigation
var siteNav = document.querySelector(".site-nav");
if (siteNav) {
    siteNav.remove();
}

// remove tagged title
var tagTitle = document.querySelector(".home h1");
if (tagTitle) {
    tagTitle.remove();
}

// remove footer
var footer= document.querySelector(".site-footer");
if (footer) {
    footer.remove();
}

//
var siteTitle = document.querySelector('.site-title');
if (siteTitle) {
    siteTitle.href = '#';
}
