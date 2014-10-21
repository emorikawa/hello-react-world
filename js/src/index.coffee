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
magical_ajax = (fn) ->
  setTimeout ->
    fn(comments_json_response)
  , 500



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

  _submitHandler: (e) ->
    e.preventDefault()
    c_author = @refs.c_author.getDOMNode().value.trim()
    c_text = @refs.c_text.getDOMNode().value.trim()
    if (not c_text) or (not c_author) then return
    @props.onCommentSubmit({author: c_author, text: c_text})
    @refs.c_author.getDOMNode().value = ""
    @refs.c_text.getDOMNode().value = ""

  render: ->
    # the `onSubmit` attribute is a React camelCase handler convention
    <form className="commentForm" onSubmit={@_submitHandler}>
      <input type="text" placeholder="Your name" ref="c_author"/>
      <input type="text" placeholder="Say something..." ref="c_text"/>
      <input type="submit" value="Post" />
    </form>

CommentBox = React.createClass

  getInitialState: ->
    my_data_var: []

  # Called automatically by React when this is rendered
  componentDidMount: ->
    # setState will re-render whatever is needed
    magical_ajax (json_response) =>
      @setState my_data_var: json_response

  # Pass this into the CommentForm's `props`
  _handleCommentSubmit: (comment_data) ->
    data = @state.my_data_var
    data = data.concat([comment_data])
    @setState my_data_var: data
    # There'd normally be some sort of ajax, but were're just gonna ignore
    # that for now

  render: ->
    <div className="commentBox">
      <h1>Comments!!!</h1>
      <CommentList data_from_props={@state.my_data_var} />
      <CommentForm onCommentSubmit={@_handleCommentSubmit}/>
    </div>

React.renderComponent(
  <CommentBox url="comments.json"/>,
  document.getElementById('app')
)

