import react.React;

class CommentBox extends React {
  static function main() {
    React.renderComponent(
      @dom '<CommentBox url="comments.json" pollInterval={2000} />',
      js.Browser.document.getElementById('content')
    );
  }

  override public function getInitialState() {
    return {data: []};
  }

  public function loadCommentsFromServer() {
    var http = new haxe.Http(this.props.url);
    http.onData = function(data : String) {
      this.setState({data : haxe.Json.parse(data) });
    };
    http.request();
  }

  public function componentWillMount() {
    this.loadCommentsFromServer();
    //js.Browser.window.setInterval(this.loadCommentsFromServer, this.props.pollInterval);
  }

  public function handleCommentSubmit(comment) {
    var comments = this.state.data;
    var newComments = comments.concat([comment]);
    this.setState({data: newComments});

    var http = new haxe.Http(this.props.url);
    //http.onData = function(data : String) {
    //  this.setState({data : haxe.Json.parse(data) });
    //};
    http.request(true);
  }

  public function render() {
    return @dom '
      <div className="commentBox">
        <h1>Comments</h1>
        <CommentList data={this.state.data} />
        <CommentForm
          onCommentSubmit={this.handleCommentSubmit}
        />
      </div>';
  }
}

class CommentList extends React {
  public function render() {
    var commentNodes = this.props.data.map(function (comment) {
      return @dom '<Comment author={comment.author}>{comment.text}</Comment>';
    });
    return @dom '
      <div className="commentList">
        {commentNodes}
      </div>';
  }
}

class CommentForm extends React {
  public function handleSubmit() {
    var author = this.refs.author.getDOMNode().value.trim();
    var text = this.refs.text.getDOMNode().value.trim();
    if (!text || !author) {
      return false;
    }
    this.props.onCommentSubmit({author: author, text: text});
    this.refs.author.getDOMNode().value = '';
    this.refs.text.getDOMNode().value = '';
    return false;
  }

  public function render() {
    return @dom '
      <form className="commentForm" onSubmit={this.handleSubmit}>
        <input type="text" placeholder="Your name" ref="author" />
        <input type="text" placeholder="Say something..." ref="text"/>
        <input type="submit" value="Post" />
      </form>';
  }
}

class Comment extends React {
  public function render() {
    var html = Markdown.markdownToHtml(this.props.children.toString());
    return @dom '
      <div className="comment">
        <h2 className="commentAuthor">
          {this.props.author}
        </h2>
        <span dangerouslySetInnerHTML={{__html: html}} />
      </div>';
  }
}