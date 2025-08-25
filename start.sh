#!/bin/bash

echo "Starting n8n with environment:"
env | grep N8N

n8n start
