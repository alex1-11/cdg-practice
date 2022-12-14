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
    @posts = [] # ['foo', 'bar', 'baz']
  end

  def index
    if @posts.empty?
      puts 'Empty here. No posts to show at all'
    else
      @posts.each.with_index { |post, index| puts "#{index}. #{post}" }
      @posts
    end
  end

  def show
    print 'Enter post`s id: '
    id = Integer(gets.chomp)
    if !id.positive?
      puts 'Error! Invalid id value. Use positive number instead'
    elsif @posts[id - 1].nil?
      print 'Post not found. '
      if @posts.empty?
        puts 'There are no posts to show at all'
      else
        puts "Try number from 1 to #{@posts.size}"
      end
    else
      puts "#{id}. #{@posts[id - 1]}"
      @posts[id - 1]
    end
  rescue ArgumentError
    puts 'Error! Invalid id type. Use integer number instead.'
  end

  def create
    puts 'create'
  end

  def update
    puts 'update'
  end

  def destroy
    puts 'destroy'
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
