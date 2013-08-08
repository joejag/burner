require 'rest_client'

def send status
    RestClient.post("http://127.0.0.1:9292/update", project_status: status)
end

def linear_project
    9.times do |x|
        send(project: 'a', team: 'b', done: x, scoped: 12, status_at: "2013-07-1#{x} 13:36:41")
    end
end

def sample_project
    # 24 plus data
    send(project: '24 plus', team: 'Blue 7', done: 51,  scoped: 312, status_at: "2012-11-20")
    send(project: '24 plus', team: 'Blue 7', done: 103, scoped: 292, status_at: "2012-12-11")
    send(project: '24 plus', team: 'Blue 7', done: 129, scoped: 312, status_at: "2012-12-20")
    send(project: '24 plus', team: 'Blue 7', done: 218, scoped: 331, status_at: "2013-01-22")
    send(project: '24 plus', team: 'Blue 7', done: 150, scoped: 406, status_at: "2013-02-12")
    send(project: '24 plus', team: 'Blue 7', done: 217, scoped: 387, status_at: "2013-03-05")
end

sample_project
