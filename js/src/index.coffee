# index.coffe
console.log "Hello World"

# Hello = React.createClass
#   render: ->
#     <h1>Hello World</h1>
#
# React.renderComponent <Hello/>, document.getElementById('example')
#

comments_json_response = [
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
    comment_nodes = @props.data_from_props.map (comment) ->
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

  getInitialState: ->
    my_data_var: []

  # Called automatically by React when this is rendered
  componentDidMount: ->
    # setState will re-render whatever is needed
    # There be "AJAX" here and "server delay"
    setTimeout =>
      @setState my_data_var: comments_json_response
    , 500

  render: ->
    <div className="commentBox">
      <h1>Comments!!!</h1>
      <CommentList data_from_props={@state.my_data_var} />
      <CommentForm />
    </div>

React.renderComponent(
  <CommentBox url="comments.json"/>,
  document.getElementById('app')
)
