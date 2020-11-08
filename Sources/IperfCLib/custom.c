//
//  custom.c
//  
//
//  Created by Igor Kim on 08.11.20.
//

#include "iperf.h"
#include "iperf_api.h"
#include <queue.h>

struct iperf_interval_results* extract_iperf_interval_results(struct iperf_stream* stream) {
    struct iperf_interval_results* interval_results = TAILQ_LAST(&stream->result->interval_results, irlisthead);
    return interval_results;
}
