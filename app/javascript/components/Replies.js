import React from "react"
import Reply from './Reply';

class Replies extends React.Component {
  render () {
    return (
      this.props.replies.map((reply, index) => {
        return <Reply key={index} reply={reply} />
      })
    );
  }
}

export default Replies
