class Matrix3d
  def initialize
    @store = [[[]]]
  end

  def [](a,b,c)
    if @store[a] == nil ||
       @store[a][b] == nil ||
       @store[a][b][c] == nil
      return nil
    else
      return @store[a][b][c]
    end
  end

  def []=(a,b,c,x)
    @store[a] = [[]] if @store[a] == nil
    @store[a][b] = [] if @store[a][b] == nil
    @store[a][b][c] = x
  end
end

# read data from text voxel file
data = []
colors = []
minx = nil
miny = nil
minz = nil
file = File.open('cat.txt', 'r:UTF-8')
file.each_line do |line|
  next if line.strip.start_with?('#')
  cols = line.strip.split(' ')
  x = cols[0].to_i
  y = cols[1].to_i
  z = cols[2].to_i
  colors.push(cols[3])
  colors.uniq!
  minx = x if minx.nil? || x < minx
  miny = y if miny.nil? || y < miny
  minz = z if minz.nil? || z < minz
  data.push({ x: x, y: y, z: z, c: colors.index(cols[3]) })
end
file.close

# normalize coordinates
maxx = nil
maxy = nil
maxz = nil
maxc = nil
data.each do |d|
  d[:x] -= minx
  d[:y] -= miny
  d[:z] -= minz
  d[:c] += 1 # empty blocks will be initialized to 0
  maxx = d[:x] if maxx.nil? || d[:x] > maxx
  maxy = d[:y] if maxy.nil? || d[:y] > maxy
  maxz = d[:z] if maxz.nil? || d[:z] > maxz
  maxc = d[:c] if maxc.nil? || d[:c] > maxc
end
puts "colors: #{colors}"
puts "max: x #{maxx}, y #{maxy}, z #{maxz}, c #{maxc}"

# initialize matrix
matrix = Matrix3d.new
data.each do |d|
  matrix[d[:x], d[:y], d[:z]] = d[:c]
end
(0..maxx).each do |x|
  (0..maxy).each do |y|
    (0..maxz).each do |z|
      matrix[x, y, z] = 0 if matrix[x, y, z].nil?
    end
  end
end

# print matrix to file
out = File.new('data.rb', 'w:UTF-8')
out.print "# voxel cat data\n"
out.print "DATA =\n"
(0..maxy).each do |y|
  (0..maxz).to_a.reverse.each do |z|
    out.print "\""
    (0..maxx).to_a.reverse.each do |x|
      out.print matrix[x,y,z]
    end
    out.print "\" +\n"
  end
  out.print "\n"
end
out.print "\"\"\n"
out.close
