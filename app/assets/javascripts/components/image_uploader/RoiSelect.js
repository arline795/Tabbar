import ReactCrop from 'react-image-crop';

export default class RoiSelect extends React.Component {
  constructor(props) {
    super(props);

    this.state = {};
  }

  onChange = (crop) => {
    this.setState({ crop }, this.onCropChange);
  }

  onCropChange = (crop) => {
    if (this.timeOut) {
      window.clearTimeout(this.timeOut);
    }
    this.timeOut = window.setTimeout(() => {
      this.props.onCrop(this.state.crop);
    }, 300);
  }

  render() {
    const { imageUrl } = this.props;
    const { crop } = this.state;

    return (
      <div>
        <ReactCrop
          src={imageUrl}
          onChange={this.onChange}
          crop={crop}
          className="border-full border-black"
        />
      </div>
    );
  }
}
