window.onload = function () {
         
    new Chart(document.getElementById("box1-chart"), {
        type: 'line',
        data: {
            labels: [01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12],
            datasets: [{
                data: [86, 114, 106, 106, 107, 111, 133, 221, 783, 2478],
                label: "Postpaid",
                borderColor: "#3e95cd",
                fill: false
            }, {
                data: [282, 350, 411, 502, 635, 809, 947, 1402, 3700, 5267],
                label: "Prepaid",
                borderColor: "#8e5ea2",
                fill: false
            }, {
                data: [168, 170, 178, 190, 203, 276, 408, 547, 975, 1534],
                label: "Reguler",
                borderColor: "#3cba9f",
                fill: false
            }, {
                data: [40, 20, 10, 16, 24, 38, 74, 167, 508, 784],
                label: "Corporate",
                borderColor: "#e8c3b9",
                fill: false
            }, {
                data: [6, 3, 2, 2, 7, 26, 82, 172, 312, 433],
                label: "VIP",
                borderColor: "#c45850",
                fill: false
            }
            ]
        },
        options: {
            title: {
                display: true,
                text: 'Customer',
				fontColor: '#fff'
            },
            legend: {
                display: false,
            },
			scales: {
				yAxes: [{
					ticks: {
						fontColor: '#fff'
					},
					gridLines: {
						display: true ,
						color: "#aaa",
						lineWidth: 0.5
					}					
				}],
				xAxes: [{
					ticks: {
						fontColor: '#fff'
					}
				}]				
			}			
        }
    });

    new Chart(document.getElementById("box2-chart"), {
        type: 'bar',
        data: {
            labels: [01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12],
            datasets: [
                {
                    label: "Month",
                    backgroundColor: ["#3e95cd", "#8e5ea2", "#3cba9f", "#e8c3b9", "#c45850"],
                    data: [24, 52, 7, 7, 4]
                }
            ]
        },
        options: {
            legend: { display: false },
            title: {
                display: true,
                text: 'Supplier',
				fontColor: '#fff'
            },
			scales: {
				yAxes: [{
					ticks: {
						fontColor: '#fff'
					},
					gridLines: {
						display: true,
						color: "#fff",
						lineWidth: 0.2
					}										
				}],
				xAxes: [{
					ticks: {
						fontColor: '#fff'
					},
					gridLines: {
						display: false,
						color: "#fff"
					}										
				}]				
			}			
        }
    });

    new Chart(document.getElementById("box3-chart"), {
        type: 'bar',
        data: {
            labels: [01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12],
            datasets: [{
                label: "Month",
                backgroundColor: ["#3e95cd", "#8e5ea2", "#3cba9f", "#e8c3b9", "#c45850"],
                data: [247, 526, 73, 98, 83]
            }]
        },
        options: {
            legend: { display: false },
            title: {
                display: true,
                text: 'Product',
				fontColor: '#fff'
            },
			scales: {
				yAxes: [{
					ticks: {
						fontColor: '#fff'
					},
					gridLines: {
						display: true,
						color: "#fff",
						lineWidth: 0.2
					}					
				}],
				xAxes: [{
					ticks: {
						fontColor: '#fff'
					}
				}]				
			}						
        }
    });   

    new Chart(document.getElementById("box4-chart"), {
        type: 'bar',
        data: {
            labels: [01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12],
            datasets: [{
                label: "Month",
                backgroundColor: ["#3e95cd", "#8e5ea2", "#3cba9f", "#e8c3b9", "#c45850"],
                data: [247, 526, 73, 98, 83]
            }]
        },
        options: {
            legend: { display: false },
            title: {
                display: true,
                text: 'Bank',
				fontColor: '#fff'
            },
			scales: {
				yAxes: [{
					ticks: {
						fontColor: '#fff'
					},
					gridLines: {
						display: true,
						color: "#fff",
						lineWidth: 0.2
					}					
				}],
				xAxes: [{
					ticks: {
						fontColor: '#fff'
					}
				}]				
			}						
        }
    });
}

var open = false;
function openNav() {
  if(open==false){
    document.getElementById("menu_sidenav").style.width = "220px";
    document.getElementById("main").style.marginLeft = "220px";
    open = true;
  }
  else{
    document.getElementById("menu_sidenav").style.width = "0";
    document.getElementById("main").style.marginLeft= "0";
    open = false;
  }
}

function closeNav() {
  document.getElementById("menu_sidenav").style.width = "0";
  document.getElementById("main").style.marginLeft= "0";
}

