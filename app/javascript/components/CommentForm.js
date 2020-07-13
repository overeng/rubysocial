import React from "react"

class CommentForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      body: '',
    }

    this.handleBodyChange = this.handleBodyChange.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  handleBodyChange(e) {
    const updatedValue = e.target.value
    this.setState(prevState => {
      return {
        body: updatedValue
      };
    });
  }

  handleSubmit(e) {
    e.preventDefault();
    var body = this.state.body.trim();
    if (!body) {
      return;
    }
    
    this.props.onSubmit({body: body});
  }

  render () {
    return (
      <div className="card my-4">
          <h5 className="card-header">Оставить комментарий:</h5>
          <div className="card-body">
            <form onSubmit={this.handleSubmit}>
              <div className="form-group">
                <textarea 
                  className="form-control" 
                  rows="3" 
                  name="body" 
                  value={this.state.body} 
                  onChange={this.handleBodyChange}></textarea>
              </div>
              <input type="hidden" value={this.props.csrf_token} />
              <button type="submit" className="btn btn-primary">Отправить</button>
            </form>
          </div>
        </div>
    );
  }
}

export default CommentForm
