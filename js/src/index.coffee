# index.coffe
console.log "Hello World"

# Hello = React.createClass
#   render: ->
#     <h1>Hello World</h1>
#
# React.renderComponent <Hello/>, document.getElementById('example')
#

converter = new Showdown.converter()
Comment = React.createClass
  render: ->
    raw_post = converter.makeHtml @props.children
    <div className="comment">
      <h2 className="commentAuthor">
        {@props.author}
      </h2>
      <span dangerouslySetInnerHTML={{__html: raw_post}} />
    </div>

CommentList = React.createClass
  render: ->
    <div className="commentList">
      Hello, world! I am a CommentList.
      <Comment author="Pete Hunt">This is [one](http://inboxapp.com) comment</Comment>
      <Comment author="Jordan Walke">This is *another* comment</Comment>
    </div>

CommentForm = React.createClass
  render: ->
    <div className="commentForm">
      Hello, world! I am a CommentForm.
    </div>

CommentBox = React.createClass
  render: ->
    <div className="commentBox">
      <h1>Comments!!!</h1>
      <CommentList data={@props.data} />
      <CommentForm />
    </div>

React.renderComponent <CommentBox data={data}/>, document.getElementById('app')
