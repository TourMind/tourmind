import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ["imageList", "inputFileElem"]
  connect() {
  }

  uploadImage(event) {
    const images = event.target.files
    this.#displayUploadedImage(images);
  }

  deleteImage(event) {
    const tmpFile = new DataTransfer();
    const { index } = event.params;
    const { files } = this.inputFileElemTarget;

    for (let i = 0; i < files.length; i++) {
      const file = files[i]
      if (index !== i)
        tmpFile.items.add(file)
    }

    this.inputFileElemTarget.files = tmpFile.files;
    this.#displayUploadedImage(this.inputFileElemTarget.files);
  }

  hiddenImage(event) {
    event.target.parentElement.parentElement.classList.add("hidden")
  }

  async #displayUploadedImage(images) {
    this.imageListTarget.innerHTML = ''
    const createImageElement = (dataUrl, index) => {
      const imageContainer = document.createElement('div');
      imageContainer.className = 'relative';
      imageContainer.innerHTML = `
      <i class="absolute top-1 right-3 ml-1 fa fa-times-circle" data-action="click->form#deleteImage" 
      data-form-index-param="${index}" 
      ></i>
      <img class="w-32 h-32 object-cover rounded px-2" src="${dataUrl}">`
      return imageContainer;
    }

    for (let i = 0; i < images.length; i++) {
      const image = images[i];
      const dataUrl = await this.#readAsDataURL(image);
      const imageElement = createImageElement(dataUrl, i);

      this.imageListTarget.append(imageElement);
    }
  }

  #readAsDataURL(file) {
    return new Promise((resolve) => {
      let fileReader = new FileReader();
      fileReader.onload = (e) => resolve(fileReader.result);
      fileReader.readAsDataURL(file);
    });
  }
}
