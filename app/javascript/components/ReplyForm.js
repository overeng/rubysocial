import React from "react"
import CommentForm from './CommentForm'

class ReplyForm extends CommentForm {
  render () {
    return (
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
    );
  }
}

export default ReplyForm
