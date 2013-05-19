module.exports = (db) ->
  db.save '_design/Word'
    look_up:
      map: (doc) ->
        a = [ 'à' , 'á' , 'ã' , 'ả' , 'ạ' , 'ă' , 'ằ' , 'ắ' , 'ẵ' , 'ă ̉' , 'ặ' , 'â' , 'ầ' , 'ấ' , 'ẫ' , 'ẩ' , 'ậ' , 'ă' , 'ắ' , 'ằ' , 'ẳ' , 'ẵ' , 'ặ' ]
        e = [ 'è' , 'é' , 'ẽ' , 'ẻ' , 'ẹ' , 'ê' , 'ề' , 'ế' , 'ễ' , 'ể' , 'ệ']
        i = [ 'ì' , 'í' , 'ĩ' , 'ỉ' , 'ị']
        o = [ 'ò' , 'ó' , 'õ' , 'ỏ' , 'ọ' , 'ô' , 'ồ' , 'ố' , 'ỗ' , 'ổ' , 'ộ' , 'ơ' , 'ờ' , 'ớ' , 'ỡ' , 'ở' , 'ợ']
        u = [ 'ù' , 'ú' , 'ũ' , 'ủ' , 'ụ' , 'ư' , 'ừ' , 'ứ' , 'ữ' , 'ử' , 'ự']
        y = [ 'ỳ' , 'ý' , 'ỹ' , 'ỷ' , 'ỵ']

        text = doc.text
        count = doc.count
        chars = text.toLowerCase().split('')

        #normalize
        for char,idx in chars
          if a.indexOf(char) > -1
            chars[idx] = 'a'
          else if e.indexOf(char) > -1
            chars[idx] = 'e'
          else if i.indexOf(char) > -1
            chars[idx] = 'i'
          else if o.indexOf(char) > -1
            chars[idx] = 'o'
          else if u.indexOf(char) > -1
            chars[idx] = 'u'
          else if y.indexOf(char) > -1
            chars[idx] = 'y'

        normalized = ''
        normalized = normalized + char for char in chars

        emit [normalized, parseInt(count)], text

  , (err, res) ->
    console.log err if err
