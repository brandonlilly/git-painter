require 'rugged'

class Painter

  attr_accessor :repo

  def initialize(repo)
    @repo = repo

  end

  def self.first_monday
    days = 24*60*60
    monday = Time.now - 52*7*days
    monday += monday.monday? ? 0 : (7 - monday.wday) * days
    monday
  end

  def commit(time:, message:, content:)
    oid = repo.write(content, :blob)
    index = repo.index
    index.read_tree(repo.head.target.tree)
    index.add(path: "canvas.txt", oid: oid, mode: 0100644)

    options = {
      tree: index.write_tree(repo),
      author: { email: "brandonjlilly@gmail.com", name: 'Brandon Lilly', time: time },
      committer: { email: "brandonjlilly@gmail.com", name: 'Brandon Lilly', time: time },
      message: message,
      parents: repo.empty? ? [] : [ repo.head.target ].compact,
      update_ref: 'HEAD',
    }

    Rugged::Commit.create(repo, options)
  end

end
