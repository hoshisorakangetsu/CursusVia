// just use js redirect to previous page for easy handling
// TODO look into this and see can it be incorporated https://stackoverflow.com/a/14038250
document.querySelector(".backControl").addEventListener("click", _e => history.go(-1));