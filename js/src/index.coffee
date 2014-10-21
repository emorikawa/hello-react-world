# index.coffe
console.log "Hello World"

# Hello = React.createClass
#   render: ->
#     <h1>Hello World</h1>
#
# React.renderComponent <Hello/>, document.getElementById('example')
#

data = [
  {author: "Evan Morikawa", text: "Check out this [awesome site](http://inboxapp.com)"},
  {author: "Michael Grinich", text: "*Sweet* stuff"}
]

converter = new Showdown.converter()
Comment = React.createClass
  render: ->
    raw_post = converter.makeHtml @props.children.toString()

    <div className="comment">
      <h2 className="commentAuthor">
        {@props.author}
      </h2>
      <span dangerouslySetInnerHTML={{__html: raw_post}} />
    </div>

CommentList = React.createClass
  render: ->
    comment_nodes = @props.data.map (comment) ->
      <Comment author={comment.author}>{comment.text}</Comment>

    <div className="commentList">
      {comment_nodes}
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

React.renderComponent(
  <CommentBox data={data}/>,
  document.getElementById('app')
)
