import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ["imageList", "uploadFileElem", "uploadTmpFileElem", "uploadFileButton"]
  connect() {
  }

  openUploadDialog(event) {
    event.preventDefault();
    this.uploadTmpFileElemTarget.click();
  }

  uploadImage(event) {
    const tmpFile = new DataTransfer();
    const images = [...this.uploadFileElemTarget.files, ...event.target.files];
    for (let i = 0; i < images.length; i++) {
      const image = images[i];
      tmpFile.items.add(image)
    }
    this.uploadFileElemTarget.files = tmpFile.files;
    this.#displayUploadedImage(images);
  }

  deleteImage(event) {
    const tmpFile = new DataTransfer();
    const { index } = event.params;
    const { files } = this.uploadFileElemTarget;

    for (let i = 0; i < files.length; i++) {
      const file = files[i]
      if (index !== i)
        tmpFile.items.add(file)
    }

    this.uploadFileElemTarget.files = tmpFile.files;
    this.#displayUploadedImage(this.uploadFileElemTarget.files);
  }

  hiddenImage(event) {
    event.target.parentElement.parentElement.classList.add("hidden")
  }

  #displayUploadedImage(images) {

    const removeElement = () => {
      const imageList = this.imageListTarget.querySelectorAll('[data-new-image]');
      const uploadButton = this.imageListTarget.querySelector('[data-upload-button]');
      if (imageList.length > 0) {
        imageList.forEach(element => element.remove());
      }
      uploadButton.remove();
    }
    const createImageElement = (dataUrl, index) => {
      const imageContainer = document.createElement('div');
      imageContainer.className = 'relative';
      imageContainer.dataset.newImage = "";
      imageContainer.innerHTML = `
      <i class="absolute top-1 right-3 cursor-pointer fa fa-times-circle shadow-[0_0_0_2px_rgba(255,255,255,0.3)] rounded-full text-white" data-action="click->form#deleteImage" 
      data-form-index-param="${index}"></i>
      <img class="w-32 h-32 object-cover rounded px-2" src="${dataUrl}">`
      return imageContainer;
    }
    const createUploadButton = () => {
      const uploadButton = document.createElement('div');
      uploadButton.className = 'cursor-pointer w-32 h-32 shadow rounded px-2 flex justify-center items-center';
      uploadButton.dataset.action = "click->form#openUploadDialog";
      uploadButton.dataset.uploadButton = "";
      uploadButton.innerHTML = `<i class="fa-solid fa-circle-plus"></i>`;
      return uploadButton;
    }

    removeElement();

    for (let i = 0; i < images.length; i++) {
      const image = images[i];
      const dataUrl = URL.createObjectURL(image);
      const imageElement = createImageElement(dataUrl, i);

      this.imageListTarget.append(imageElement);
    }
    this.imageListTarget.append(createUploadButton());
  }
}
