import React from "react"
import PropTypes from "prop-types"
class Reply extends React.Component {
  render () {
    return (
      <div className="media mt-4">
        <img className="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="" />
        <div className="media-body">
          <h5 className="mt-0">Commenter Name</h5>
            {this.props.reply.body}
          </div>
      </div>
    );
  }
}

export default Reply
