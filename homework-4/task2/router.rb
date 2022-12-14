module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp
      break if verb == 'q'

      action = nil

      if verb == 'GET'
        print 'Choose action (index/show) / q to exit: '
        action = gets.chomp
        break if action == 'q'
      end


      action.nil? ? routes[verb].call : routes[verb][action].call
    end
  end
end

class PostsController
  extend Resource

  def initialize
    @posts = ['foo', 'bar', 'baz']
  end

  # Asks user to input id of post. Returns positive integer (or nil if invalid)
  def get_post_id
    print 'Enter post`s id: '
    id = Integer(gets.chomp)
    if !id.positive?
      puts 'Error! Invalid id value. Use positive number instead'
      nil
    elsif @posts[id - 1].nil?
      print 'Post not found. '
      if @posts.empty?
        puts 'There are no posts at all'
      else
        puts "Try number from 1 to #{@posts.size}"
      end
      nil
    else
      id
    end
  rescue ArgumentError
    puts 'Error! Invalid id type. Use integer number instead.'
    nil
  end

  def get_post_text(action)
    print 'Write text here: '
    text = gets.chomp
    return puts "Error! Can`t #{action} with no text" if text.empty?

    text
  end

  # Puts to the console all the posts (packed in indexed list)
  def index
    if @posts.empty?
      puts 'Empty here. No posts to show at all'
    else
      # Puts index from 0-indexed array (but for UX #{index + 1} would be better)
      # It is considered that posts have regular one-indexed list of IDs
      # But `index` method puts indeces 0-based because of task's definition
      @posts.each.with_index { |post, index| puts "#{index}. #{post}" }
      @posts
    end
  end

  # Asks for post id to find and puts it to the console
  def show
    id = get_post_id
    if id
      puts "#{id}. #{@posts[id - 1]}"
      @posts[id - 1]
    end
  end

  # Asks for text (not empty) and pushes it to posts array
  def create
    puts 'Creation initialized...'
    post = get_post_text('create')
    return puts 'Creation aborted' if post.nil?

    @posts << post
    puts 'Created new post (id. text):',
         "#{@posts.size}. #{@posts[-1]}"
    @posts[-1]
  end

  def update
    puts 'Update initialized...'
    id = get_post_id
    return puts 'Update aborted' if id.nil?

    new_text = get_post_text(update)
    return puts 'Update aborted' if new_text.nil?

    @posts[id] = new_text
    puts 'Updated post (id. text):',
         "#{id}. #{@posts[id]}"
    @posts[id]
  end

  def destroy
    puts 'DESTRUCTION INITIALIZED!!!11...'
    id = get_post_id
    return puts 'DESTRUCTION aborted =)' if id.nil?

    @posts.delete_at(id - 1)
    puts "Deleted post ##{id}"
    id
  end
end

class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.chomp

      PostsController.connection(@routes['posts']) if choise == '1'
      break if choise == 'q'
    end

    puts 'Good bye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init
