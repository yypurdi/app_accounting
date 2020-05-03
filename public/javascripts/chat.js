$(function () {
  
  /*
   * Socket IO for Signaling
   */
  var socket = io.connect('https://localhost:3000')
  var inbox_chat = $("#inbox_chat")
  var contact_chat = $("#contact_chat")  
  var message_chat = $("#message_chat")
  var message_text = $("#message_text")
  var inbox_chat_list = $('#inbox_chat_list');
  var contactTable = $('#contactTable');

  var outgoingtone = document.getElementById("outgoingtone");
  var incomingtone = document.getElementById("incomingtone");    

  var username = $('#username').val();
  var domain = $('#domain').val();
  var sessionid = $('#sessionid').val();
  var auth = {
      id : sessionid,
      username : username,
      token : '1234567890',
      domain : domain,
      resource : 'web',
      show : 'unavailable',
      status : 'Offline'
  }

  $("#chatPanel").click(function () {
    $('#inbox').addClass('popup-box-on');
  });

  $("#chatPanelHeader").click(function () {
    $('#inbox').addClass('popup-box-on');
  });

  $("#closeInbox").click(function () {
    $('#inbox').removeClass('popup-box-on');
  });

  $("#openContact").click(function () {
    $('#contacts').addClass('popup-box-on');
  });

  $("#closeContact").click(function () {
    $('#contacts').removeClass('popup-box-on');
  });

  $("#openChat").click(function () {
    $('#messages').addClass('popup-box-on');
  });

  $("#closeChat").click(function () {
    $('#messages').removeClass('popup-box-on');
  });

  inbox_chat.on('click','.user-chat',function(){
    auth.to = $(this)[0].getAttribute('id');
    $("#jid").html('<td><img src="images/avatar1.png" alt="" class="avatar green"></td>'+
    '<td class="card">'+
    '  <p class="name">'+auth.to+'</p>'+
    '  <p class="status">Online</p>'+
    '</td>');
    $("#msg_history").html('');
    $('#messages').addClass('popup-box-on');    
  });

  contact_chat.on('click','.user-contact',function(){
    auth.to = $(this)[0].getAttribute('id');
    $("#jid").html('<td><img src="images/avatar1.png" alt="" class="avatar green"></td>'+
    '<td class="card">'+
    '  <p class="name">'+auth.to+'</p>'+
    '  <p class="status">Online</p>'+
    '</td>');
    $("#msg_history").html('');
    $('#messages').addClass('popup-box-on');    
  });

  message_chat.keyup(function(e){
    var code = (e.keyCode ? e.keyCode : e.which);
    if (code == 13) {
      let text = document.getElementById('message_chat').value;
      let ref = document.getElementById('message_chat').value.replace(new RegExp('\r?\n','g'), '');
      if(ref.length > 0){
        text = text.substr(0,text.length-1);
        let msg = {
          from : auth.username+'@'+auth.domain,
          to : auth.to,         
          body : text
        }
        socket.emit('message',msg);        
      }
      document.getElementById('message_chat').value = "";
    }
  })

  $('#inviteVideoCall').click(function(){
    console.log('invite Video Call');
    socket.emit('invite',{from : auth.username+'@'+auth.domain,to : auth.to, sip:'invite'});
  })

  $('#cancelCall').click(function(){
    console.log('cancel Call');
    outgoingtone.pause();    
    socket.emit('cancel',{from : auth.username+'@'+auth.domain,to : auth.to, sip:'cancel'});
    $('#outgoingCallBox').removeClass('popup-box-on');
  })

  $('#rejectCall').click(function(){
    console.log('reject Call');
    incomingtone.pause();    
    socket.emit('rejected',{from : auth.username+'@'+auth.domain,to : auth.to, sip:'rejected'});
    $('#incomingCallBox').removeClass('popup-box-on');
  })

  $('#acceptCall').click(function(){
    console.log('accept Call');
    incomingtone.pause();    
    
    $('#incomingCallBox').removeClass('popup-box-on');
    
    $("#jid-vc").html('<td><img src="images/avatar1.png" alt="" class="avatar green"></td>'+
    '<td class="card">'+
    '  <p class="name">'+auth.to+'</p>'+
    '  <p class="status">Online</p>'+
    '</td>');
    $('#localVideoBox').addClass('popup-box-on');

    acceptVideoCall();
  })

  $('#videoCall').click(function(){
    start(true);    
  })

  socket.on('connect', function(){
    console.log('connected');
    socket.emit("auth",auth);
  });

  socket.on('success', function(success){
    console.log('success');
    socket.emit("roster",success);
  });

  socket.on('failure', function(failure){
    console.log('io connection failed');
  });  

  socket.on('roster', function(roster){
    for(let n in roster){
      console.log(roster[n].jid+','+roster[n].status);
      var num = Math.floor(Math.random() * 5) + 1;
      var contactChat = '<tr id="'+roster[n].jid+'" class="user-chat">'+
      '  <td><img src="images/avatar'+num+'.png" alt="" class="avatar"></td>'+
      '  <td class="card">'+
      '    <p class="name">'+roster[n].nickname+'</p>'+
      '    <p class="status">'+roster[n].status+'</p>'+
      '  </td>'+
      '</tr>'
      inbox_chat_list.append(contactChat);
      var contactCard = '<tr id="'+roster[n].jid+'" class="user-contact">'+
      '  <td><img src="images/avatar'+num+'.png" alt="" class="avatar"></td>'+
      '  <td class="card">'+
      '    <p class="name">'+roster[n].nickname+'</p>'+
      '    <p class="status"><span class="glyphicon glyphicon-comment"></span>'+roster[n].jid+'</p>'+
      '    <p class="status"><span class="glyphicon glyphicon-earphone"></span>62816630999</p>'+
      '  </td>'+
      '</tr>'
      contactTable.append(contactCard);
    }
    socket.emit("presence",auth);
  });

  socket.on('presence', function(presence){
    console.log(presence);
  });

  socket.on('message', function(jsonObj){
    console.log(jsonObj);
      if(jsonObj.body!=undefined){
          if(jsonObj.from == auth.username+'@'+auth.domain){
              let text = jsonObj.body;
              let dtime = jsonObj.dtime;
              text = text.replace(new RegExp('\r?\n','g'), '<br />');
              var msg = '<div class="container right">'+
              '  <div class="content right">'+
              '    <p>'+text+'</p>'+
              '    <p class="dt">'+dtime+'</p>'+
              '  </div>'+
              '</div>';
              message_text.append(msg);
          }
          else{
              let text = jsonObj.body;
              let dtime = jsonObj.dtime;
              text = text.replace(new RegExp('\r?\n','g'), '<br />');
              var msg = '<div class="container left">'+
              '  <div class="content">'+
              '    <p>'+text+'</p>'+
              '    <p class="dt">'+dtime+'</p>'+
              '  </div>'+
              '</div>';
              message_text.append(msg);
          }
          message_text.scrollTop($('#message_text')[0].scrollHeight);
      }	
  });

  socket.on('invite',function(jsonObj){
    auth.to = jsonObj.from;
    console.log('on invite');
    socket.emit('ringing',{from : auth.username+'@'+auth.domain,to : jsonObj.from, sip:'ringing'});
    $("#jid-incoming").html('<td><img src="images/avatar1.png" alt="" class="avatar green"></td>'+
    '<td class="card">'+
    '  <p class="name">'+jsonObj.from+'</p>'+
    '  <p class="status">Online</p>'+
    '</td>');
    $('#incomingCallBox').addClass('popup-box-on');    
    incomingtone.loop = true;
    try{
      incomingtone.play();
    }catch(error){
      console.log(error);
      incomingtone.play();
    }
  });

  socket.on('ringing', function(jsonObj){
    console.log('on ringing');
    $("#jid-outgoing").html('<td><img src="images/avatar1.png" alt="" class="avatar green"></td>'+
    '<td class="card">'+
    '  <p class="name">'+auth.to+'</p>'+
    '  <p class="status">Online</p>'+
    '</td>');
    $('#outgoingCallBox').addClass('popup-box-on');
    outgoingtone.pause();
    outgoingtone.loop = true;
    outgoingtone.play();    
  });

  socket.on('cancel', function(jsonObj){
    console.log('on cancel');
    incomingtone.pause();
    $('#incomingCallBox').removeClass('popup-box-on');    
  });

  socket.on('rejected', function(jsonObj){
    console.log('on rejected');
    outgoingtone.pause();
    $('#outgoingCallBox').removeClass('popup-box-on');    
  });

  socket.on('accepted', function(jsonObj){
    console.log('on accepted');
    outgoingtone.pause();
    $('#outgoingCallBox').removeClass('popup-box-on');

    $("#jid-vc").html('<td><img src="images/avatar1.png" alt="" class="avatar green"></td>'+
    '<td class="card">'+
    '  <p class="name">'+auth.to+'</p>'+
    '  <p class="status">Online</p>'+
    '</td>');
    $('#localVideoBox').addClass('popup-box-on');
    
    startVideoCall();
  });

  socket.on('ack', function(jsonObj){
    console.log('on ack');
  });

  socket.on('webrtc-sdp', function(data){
    console.log('on webrtc-sdp');
    var signal = data.content;
    if(!peerConnection) start(false);
    if(signal.uuid == uuid) return;
    peerConnection.setRemoteDescription(new RTCSessionDescription(signal.sdp)).then(function() {
      if(signal.sdp.type == 'offer') {
        peerConnection.createAnswer().then(createdDescription).catch(function errorHandler(error) {
          console.log('createAnswer : '+error);
        });
      }
    }).catch(function errorHandler(error) {
      console.log('setRemoteDescription : '+error);
    });
  });

  socket.on('webrtc-ice', function(data){
    console.log('on webrtc-ice');
    var signal = data.content;    
    peerConnection.addIceCandidate(new RTCIceCandidate(signal.ice)).catch(function errorHandler(error) {
      console.log('addIceCandidate : '+error);
    });
  });

  socket.on('disconnect', function(){
  });
  
  /*
   * WebRTC Component
   */
  var localVideo;
  var remoteVideo;
  var localStream;
  var peerConnection;
  var uuid;
  
  var peerConnectionConfig = {
    'iceServers': [
      {'urls': 'stun:stun.stunprotocol.org:3478'},
      {'urls': 'stun:stun.l.google.com:19302'},
    ]
  };

  /*
   * User Media Initiation
   */
  function acceptVideoCall(){
    
    localVideo = document.getElementById('localVideo1');
    remoteVideo = document.getElementById('remoteVideo1');

    var constraints = {
      video: true,
      audio: true,
    };
  
    if(navigator.mediaDevices.getUserMedia) {
      navigator.mediaDevices.getUserMedia(constraints).then(function getUserMediaSuccess(stream) {
        localStream = stream;
        localVideo.srcObject = stream;
        socket.emit('accepted',{from : auth.username+'@'+auth.domain,to : auth.to, sip:'accepted'});

      }).catch(function errorHandler(error) {
        console.log('initVideoCall : '+error);
      });
    } else {
      alert('Your browser does not support getUserMedia API');
    }
  }

  function startVideoCall(){
    
    localVideo = document.getElementById('localVideo1');
    remoteVideo = document.getElementById('remoteVideo1');

    var constraints = {
      video: true,
      audio: true,
    };
  
    if(navigator.mediaDevices.getUserMedia) {
      navigator.mediaDevices.getUserMedia(constraints).then(function getUserMediaSuccess(stream) {
        localStream = stream;
        localVideo.srcObject = stream;
        start(true);

      }).catch(function errorHandler(error) {
        console.log('initVideoCall : '+error);
      });
    } else {
      alert('Your browser does not support getUserMedia API');
    }
  }
  
  /*
   * RTP Preparation
   */
  function start(isCaller) {
    uuid = createUUID();
    peerConnection = new RTCPeerConnection(peerConnectionConfig);
    peerConnection.ontrack = gotRemoteStream;
    peerConnection.addStream(localStream);
    if(isCaller) {
      peerConnection.createOffer().then(createdDescription).catch(function errorHandler(error) {
        console.log('start : '+error);
      });
    }
  }

  /*
   * GET Remote Stream
   */
  function gotRemoteStream(event) {
    console.log('got remote stream');
    remoteVideo.srcObject = event.streams[0];
  }
    
  /*
   * SDP Protocol
   */
  function createdDescription(description) {
    console.log('create description');  
    peerConnection.setLocalDescription(description).then(function() {
      socket.emit('webrtc-sdp',createMsg({'sdp': peerConnection.localDescription, 'uuid': uuid}));
      peerConnection.onicecandidate = function (event) {
        if (!event || !event.candidate) return;
        socket.emit('webrtc-ice',createMsg({'ice': event.candidate, 'uuid': uuid}));
      };  
    }).catch(function errorHandler(error) {
      console.log('error description : '+error);
    });
  }

  function createMsg(obj){
    let msg = {
      from : auth.username+'@'+auth.domain,
      to : auth.to,         
      content : obj
    }
    return msg;
  }

  /*
   * Create UUID or ID for RTC
   */
  function createUUID() {
    function s4() {
      return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);
    }
    return s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4();
  }
  
  $('#stopVideoCall').click(function(){
    try{
      localStream.getAudioTracks()[0].stop();
      localStream.getVideoTracks()[0].stop();
      localStream.getTracks().map(function (val) {
        val.stop();    
      });
      if(remoteVideo.srcObject){
        remoteVideo.srcObject.getTracks().map(function (val) {
          val.stop();    
        });
      }
      peerConnection = null;
      $('#localVideoBox').removeClass('popup-box-on');
    }catch(error){
      console.log(error);
      peerConnection = null;
      $('#localVideoBox').removeClass('popup-box-on');  
    }
  })
})
