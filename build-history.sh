#!/bin/bash

# build-history.sh
# Creates practice history for Git rebasing exercises
# Simulates a blog platform project with multiple developers and feature branches

set -e  # Exit on error

echo "🚀 Building Git history for rebasing practice..."
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if src/ directory already exists
if [ -d "src" ]; then
    echo -e "${YELLOW}⚠️  Warning: src/ directory already exists${NC}"
    read -p "Delete and rebuild? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborting."
        exit 1
    fi
    rm -rf src/
    # Clean up any existing branches
    git branch | grep -v "^\*" | grep -v "master" | grep -v "main" | xargs -r git branch -D 2>/dev/null || true
fi

echo -e "${BLUE}📁 Creating project structure...${NC}"

# Create directory structure
mkdir -p src

# Developer information
export GIT_AUTHOR_NAME="Sarah Chen"
export GIT_AUTHOR_EMAIL="sarah@example.com"
export GIT_COMMITTER_NAME="Sarah Chen"
export GIT_COMMITTER_EMAIL="sarah@example.com"

# Commit 1: Initial blog structure
export GIT_AUTHOR_DATE="2024-01-15T09:00:00"
export GIT_COMMITTER_DATE="2024-01-15T09:00:00"
cat > src/blog.js << 'EOF'
// Blog Platform - Main Module
// Manages core blog functionality

class BlogPlatform {
    constructor() {
        this.posts = [];
        this.authors = new Map();
    }

    initialize() {
        console.log('Blog platform initialized');
        this.loadPosts();
    }

    loadPosts() {
        // Load posts from database
        console.log('Loading posts...');
    }
}

module.exports = BlogPlatform;
EOF
git add src/blog.js
git commit -m "Initial blog platform structure

Set up main blog module with basic initialization."

# Commit 2: Add posts module
export GIT_AUTHOR_DATE="2024-01-15T10:30:00"
export GIT_COMMITTER_DATE="2024-01-15T10:30:00"
cat > src/posts.js << 'EOF'
// Posts Management Module

class PostManager {
    constructor() {
        this.posts = [];
    }

    createPost(title, content, authorId) {
        const post = {
            id: this.generateId(),
            title,
            content,
            authorId,
            createdAt: new Date()
        };
        this.posts.push(post);
        return post;
    }

    generateId() {
        return Math.random().toString(36).substr(2, 9);
    }

    getAllPosts() {
        return this.posts;
    }
}

module.exports = PostManager;
EOF
git add src/posts.js
git commit -m "Add post management module

Implement create and retrieve functionality."

# Switch developer: Mike Johnson
export GIT_AUTHOR_NAME="Mike Johnson"
export GIT_AUTHOR_EMAIL="mike@example.com"
export GIT_COMMITTER_NAME="Mike Johnson"
export GIT_COMMITTER_EMAIL="mike@example.com"

# Commit 3: Add comments module
export GIT_AUTHOR_DATE="2024-01-16T09:00:00"
export GIT_COMMITTER_DATE="2024-01-16T09:00:00"
cat > src/comments.js << 'EOF'
// Comments System Module

class CommentManager {
    constructor() {
        this.comments = [];
    }

    addComment(postId, userId, text) {
        const comment = {
            id: this.generateId(),
            postId,
            userId,
            text,
            createdAt: new Date()
        };
        this.comments.push(comment);
        return comment;
    }

    getCommentsForPost(postId) {
        return this.comments.filter(c => c.postId === postId);
    }

    generateId() {
        return Math.random().toString(36).substr(2, 9);
    }
}

module.exports = CommentManager;
EOF
git add src/comments.js
git commit -m "Add comments system

Users can now comment on blog posts."

# Commit 4: Add authentication stub
export GIT_AUTHOR_DATE="2024-01-16T11:00:00"
export GIT_COMMITTER_DATE="2024-01-16T11:00:00"
cat > src/auth.js << 'EOF'
// Authentication Module

class AuthManager {
    constructor() {
        this.users = new Map();
        this.sessions = new Map();
    }

    register(username, password) {
        // Simplified registration
        const userId = this.generateUserId();
        this.users.set(userId, { username, password });
        return userId;
    }

    login(username, password) {
        // Simplified login
        for (let [userId, user] of this.users) {
            if (user.username === username && user.password === password) {
                const sessionId = this.createSession(userId);
                return sessionId;
            }
        }
        return null;
    }

    generateUserId() {
        return Math.random().toString(36).substr(2, 9);
    }

    createSession(userId) {
        const sessionId = Math.random().toString(36).substr(2, 16);
        this.sessions.set(sessionId, userId);
        return sessionId;
    }
}

module.exports = AuthManager;
EOF
git add src/auth.js
git commit -m "Add authentication module

Basic user registration and login."

echo -e "${GREEN}✅ Master branch setup complete (4 commits)${NC}"
echo ""

# Create feature branch: posts-ui
echo -e "${BLUE}🌿 Creating feature/posts-ui branch...${NC}"
git checkout -b feature/posts-ui HEAD~2  # Branch from commit 2

# Switch developer: Sarah Chen
export GIT_AUTHOR_NAME="Sarah Chen"
export GIT_AUTHOR_EMAIL="sarah@example.com"
export GIT_COMMITTER_NAME="Sarah Chen"
export GIT_COMMITTER_EMAIL="sarah@example.com"

# Feature commit 1: Add UI module
export GIT_AUTHOR_DATE="2024-01-15T14:00:00"
export GIT_COMMITTER_DATE="2024-01-15T14:00:00"
cat > src/ui.js << 'EOF'
// User Interface Module

class UIManager {
    constructor() {
        this.container = null;
    }

    initialize(containerId) {
        this.container = document.getElementById(containerId);
    }

    renderPosts(posts) {
        const html = posts.map(post => `
            <div class="post">
                <h2>${post.title}</h2>
                <p>${post.content}</p>
            </div>
        `).join('');
        
        this.container.innerHTML = html;
    }
}

module.exports = UIManager;
EOF
git add src/ui.js
git commit -m "Add UI module for post rendering

Basic HTML rendering for blog posts."

# Feature commit 2: Enhance UI
export GIT_AUTHOR_DATE="2024-01-15T16:00:00"
export GIT_COMMITTER_DATE="2024-01-15T16:00:00"
cat > src/ui.js << 'EOF'
// User Interface Module

class UIManager {
    constructor() {
        this.container = null;
    }

    initialize(containerId) {
        this.container = document.getElementById(containerId);
    }

    renderPosts(posts) {
        const html = posts.map(post => this.renderPost(post)).join('');
        this.container.innerHTML = html;
    }

    renderPost(post) {
        return `
            <article class="post">
                <h2 class="post-title">${post.title}</h2>
                <div class="post-meta">
                    <span>By ${post.authorId}</span>
                    <span>${this.formatDate(post.createdAt)}</span>
                </div>
                <div class="post-content">${post.content}</div>
            </article>
        `;
    }

    formatDate(date) {
        return new Date(date).toLocaleDateString();
    }
}

module.exports = UIManager;
EOF
git add src/ui.js
git commit -m "Enhance post rendering with metadata

Display author and date for each post."

echo -e "${GREEN}✅ feature/posts-ui branch created (2 commits)${NC}"

# Back to master
git checkout master

# Create feature branch: comments-system
echo -e "${BLUE}🌿 Creating feature/comments-system branch...${NC}"
git checkout -b feature/comments-system HEAD~1  # Branch from commit 3

# Switch developer: Mike Johnson
export GIT_AUTHOR_NAME="Mike Johnson"
export GIT_AUTHOR_EMAIL="mike@example.com"
export GIT_COMMITTER_NAME="Mike Johnson"
export GIT_COMMITTER_EMAIL="mike@example.com"

# Feature commit 1: Enhance comments
export GIT_AUTHOR_DATE="2024-01-16T14:00:00"
export GIT_COMMITTER_DATE="2024-01-16T14:00:00"
cat > src/comments.js << 'EOF'
// Comments System Module

class CommentManager {
    constructor() {
        this.comments = [];
    }

    addComment(postId, userId, text) {
        if (!text || text.trim().length === 0) {
            throw new Error('Comment text cannot be empty');
        }

        const comment = {
            id: this.generateId(),
            postId,
            userId,
            text: text.trim(),
            createdAt: new Date(),
            likes: 0
        };
        this.comments.push(comment);
        return comment;
    }

    getCommentsForPost(postId) {
        return this.comments.filter(c => c.postId === postId);
    }

    likeComment(commentId) {
        const comment = this.comments.find(c => c.id === commentId);
        if (comment) {
            comment.likes++;
        }
    }

    generateId() {
        return Math.random().toString(36).substr(2, 9);
    }
}

module.exports = CommentManager;
EOF
git add src/comments.js
git commit -m "Add comment validation and likes

Comments now require text and support likes."

echo -e "${GREEN}✅ feature/comments-system branch created (1 commit)${NC}"

# Back to master
git checkout master

# Create feature branch: auth-system
echo -e "${BLUE}🌿 Creating feature/auth-system branch...${NC}"
git checkout -b feature/auth-system  # Branch from latest master

# Switch developer: Emily Rodriguez
export GIT_AUTHOR_NAME="Emily Rodriguez"
export GIT_AUTHOR_EMAIL="emily@example.com"
export GIT_COMMITTER_NAME="Emily Rodriguez"
export GIT_COMMITTER_EMAIL="emily@example.com"

# Feature commit 1: Improve auth
export GIT_AUTHOR_DATE="2024-01-17T09:00:00"
export GIT_COMMITTER_DATE="2024-01-17T09:00:00"
cat > src/auth.js << 'EOF'
// Authentication Module

class AuthManager {
    constructor() {
        this.users = new Map();
        this.sessions = new Map();
    }

    register(username, password, email) {
        // Validate input
        if (!username || !password || !email) {
            throw new Error('All fields are required');
        }

        // Check if username exists
        for (let user of this.users.values()) {
            if (user.username === username) {
                throw new Error('Username already exists');
            }
        }

        const userId = this.generateUserId();
        this.users.set(userId, { username, password, email });
        return userId;
    }

    login(username, password) {
        for (let [userId, user] of this.users) {
            if (user.username === username && user.password === password) {
                const sessionId = this.createSession(userId);
                return sessionId;
            }
        }
        throw new Error('Invalid credentials');
    }

    logout(sessionId) {
        this.sessions.delete(sessionId);
    }

    validateSession(sessionId) {
        return this.sessions.has(sessionId);
    }

    generateUserId() {
        return Math.random().toString(36).substr(2, 9);
    }

    createSession(userId) {
        const sessionId = Math.random().toString(36).substr(2, 16);
        this.sessions.set(sessionId, userId);
        return sessionId;
    }
}

module.exports = AuthManager;
EOF
git add src/auth.js
git commit -m "Enhance authentication with validation

Add input validation, error handling, and logout."

echo -e "${GREEN}✅ feature/auth-system branch created (1 commit)${NC}"

# Back to master, add a commit that will conflict with posts-ui
git checkout master

# Switch developer: Sarah Chen
export GIT_AUTHOR_NAME="Sarah Chen"
export GIT_AUTHOR_EMAIL="sarah@example.com"
export GIT_COMMITTER_NAME="Sarah Chen"
export GIT_COMMITTER_EMAIL="sarah@example.com"

# Master commit 5: Add API module (will conflict with some branches)
export GIT_AUTHOR_DATE="2024-01-17T10:00:00"
export GIT_COMMITTER_DATE="2024-01-17T10:00:00"
cat > src/api.js << 'EOF'
// API Module

class APIManager {
    constructor(postManager, commentManager) {
        this.postManager = postManager;
        this.commentManager = commentManager;
    }

    getPosts() {
        return this.postManager.getAllPosts();
    }

    createPost(title, content, authorId) {
        return this.postManager.createPost(title, content, authorId);
    }

    getComments(postId) {
        return this.commentManager.getCommentsForPost(postId);
    }

    addComment(postId, userId, text) {
        return this.commentManager.addComment(postId, userId, text);
    }
}

module.exports = APIManager;
EOF
git add src/api.js
git commit -m "Add API module for unified interface

Provides clean API for frontend to use."

# Master commit 6: Update posts module (will conflict with posts-api branch)
export GIT_AUTHOR_DATE="2024-01-17T14:00:00"
export GIT_COMMITTER_DATE="2024-01-17T14:00:00"
cat > src/posts.js << 'EOF'
// Posts Management Module

class PostManager {
    constructor() {
        this.posts = [];
    }

    createPost(title, content, authorId) {
        // Add validation
        if (!title || !content) {
            throw new Error('Title and content are required');
        }

        const post = {
            id: this.generateId(),
            title,
            content,
            authorId,
            createdAt: new Date(),
            status: 'draft'
        };
        this.posts.push(post);
        return post;
    }

    publishPost(postId) {
        const post = this.posts.find(p => p.id === postId);
        if (post) {
            post.status = 'published';
            post.publishedAt = new Date();
        }
    }

    generateId() {
        return Math.random().toString(36).substr(2, 9);
    }

    getAllPosts() {
        return this.posts.filter(p => p.status === 'published');
    }
}

module.exports = PostManager;
EOF
git add src/posts.js
git commit -m "Add post validation and publishing

Posts now require validation and have draft/published status."

echo -e "${GREEN}✅ Master branch extended (6 commits total)${NC}"

# Create feature branch with conflicts: posts-api
echo -e "${BLUE}🌿 Creating feature/posts-api branch (will have conflicts)...${NC}"
git checkout -b feature/posts-api HEAD~2  # Branch before last 2 commits

# Switch developer: David Kim
export GIT_AUTHOR_NAME="David Kim"
export GIT_AUTHOR_EMAIL="david@example.com"
export GIT_COMMITTER_NAME="David Kim"
export GIT_COMMITTER_EMAIL="david@example.com"

# Feature commit: Modify posts (will conflict)
export GIT_AUTHOR_DATE="2024-01-17T11:00:00"
export GIT_COMMITTER_DATE="2024-01-17T11:00:00"
cat > src/posts.js << 'EOF'
// Posts Management Module

class PostManager {
    constructor() {
        this.posts = [];
        this.tags = new Map();
    }

    createPost(title, content, authorId, tags = []) {
        const post = {
            id: this.generateId(),
            title,
            content,
            authorId,
            tags,
            createdAt: new Date(),
            views: 0
        };
        this.posts.push(post);
        
        // Index tags
        tags.forEach(tag => {
            if (!this.tags.has(tag)) {
                this.tags.set(tag, []);
            }
            this.tags.get(tag).push(post.id);
        });
        
        return post;
    }

    getPostsByTag(tag) {
        const postIds = this.tags.get(tag) || [];
        return this.posts.filter(p => postIds.includes(p.id));
    }

    incrementViews(postId) {
        const post = this.posts.find(p => p.id === postId);
        if (post) {
            post.views++;
        }
    }

    generateId() {
        return Math.random().toString(36).substr(2, 9);
    }

    getAllPosts() {
        return this.posts;
    }
}

module.exports = PostManager;
EOF
git add src/posts.js
git commit -m "Add tags and view tracking to posts

Posts now support tagging and view counting."

echo -e "${GREEN}✅ feature/posts-api branch created (will conflict with master)${NC}"

# Create complex branch for abort exercise
git checkout master
echo -e "${BLUE}🌿 Creating feature/complex-changes branch...${NC}"
git checkout -b feature/complex-changes HEAD~3

# Multiple conflicting changes
export GIT_AUTHOR_DATE="2024-01-16T15:00:00"
export GIT_COMMITTER_DATE="2024-01-16T15:00:00"

# Modify multiple files
cat > src/blog.js << 'EOF'
// Blog Platform - Main Module
// REFACTORED VERSION

class BlogPlatform {
    constructor(config) {
        this.posts = [];
        this.authors = new Map();
        this.config = config || {};
    }

    async initialize() {
        console.log('Initializing blog platform...');
        await this.loadConfiguration();
        await this.loadPosts();
        console.log('Blog platform ready!');
    }

    async loadConfiguration() {
        // Load config from file
        console.log('Loading configuration...');
    }

    async loadPosts() {
        // Load posts asynchronously
        console.log('Loading posts from database...');
    }
}

module.exports = BlogPlatform;
EOF

cat > src/comments.js << 'EOF'
// Comments System Module
// REFACTORED VERSION

class CommentManager {
    constructor(database) {
        this.comments = [];
        this.database = database;
    }

    async addComment(postId, userId, text) {
        const comment = {
            id: await this.generateId(),
            postId,
            userId,
            text,
            createdAt: new Date(),
            replies: []
        };
        
        await this.database.save(comment);
        this.comments.push(comment);
        return comment;
    }

    async getCommentsForPost(postId) {
        return this.comments.filter(c => c.postId === postId);
    }

    async addReply(commentId, userId, text) {
        const comment = this.comments.find(c => c.id === commentId);
        if (comment) {
            comment.replies.push({ userId, text, createdAt: new Date() });
            await this.database.update(comment);
        }
    }

    async generateId() {
        return Math.random().toString(36).substr(2, 9);
    }
}

module.exports = CommentManager;
EOF

git add src/blog.js src/comments.js
git commit -m "Major refactor: async/await and database integration

This will cause many conflicts with master."

echo -e "${GREEN}✅ feature/complex-changes branch created (for abort practice)${NC}"

# Create branch for cleanup exercise
git checkout master
echo -e "${BLUE}🌿 Creating feature/needs-cleanup branch...${NC}"
git checkout -b feature/needs-cleanup

# Switch developer: Sarah Chen
export GIT_AUTHOR_NAME="Sarah Chen"
export GIT_AUTHOR_EMAIL="sarah@example.com"
export GIT_COMMITTER_NAME="Sarah Chen"
export GIT_COMMITTER_EMAIL="sarah@example.com"

# Make messy WIP commits
export GIT_AUTHOR_DATE="2024-01-18T09:00:00"
export GIT_COMMITTER_DATE="2024-01-18T09:00:00"
cat > src/search.js << 'EOF'
// Search functionality
function search(query) {
    console.log('Searching for: ' + query);
}
module.exports = { search };
EOF
git add src/search.js
git commit -m "WIP: start search feature"

export GIT_AUTHOR_DATE="2024-01-18T09:30:00"
export GIT_COMMITTER_DATE="2024-01-18T09:30:00"
cat > src/search.js << 'EOF'
// Search functionality
function search(query) {
    console.log('Searching for: ' + query);
    // TODO: implement
    return [];
}
module.exports = { search };
EOF
git add src/search.js
git commit -m "WIP: add return"

export GIT_AUTHOR_DATE="2024-01-18T10:00:00"
export GIT_COMMITTER_DATE="2024-01-18T10:00:00"
cat > src/search.js << 'EOF'
// Search functionality
function search(query, posts) {
    console.log('Searching for: ' + query);
    
    return posts.filter(post => 
        post.title.includes(query) || post.content.includes(query)
    );
}
module.exports = { search };
EOF
git add src/search.js
git commit -m "WIP: basic implementation"

export GIT_AUTHOR_DATE="2024-01-18T10:30:00"
export GIT_COMMITTER_DATE="2024-01-18T10:30:00"
cat > src/search.js << 'EOF'
// Search functionality

function search(query, posts) {
    if (!query || query.trim().length === 0) {
        return posts;
    }
    
    const lowerQuery = query.toLowerCase();
    
    return posts.filter(post => 
        post.title.toLowerCase().includes(lowerQuery) || 
        post.content.toLowerCase().includes(lowerQuery)
    );
}

module.exports = { search };
EOF
git add src/search.js
git commit -m "Complete search feature"

# Add tests
export GIT_AUTHOR_DATE="2024-01-18T11:00:00"
export GIT_COMMITTER_DATE="2024-01-18T11:00:00"
cat > src/search.test.js << 'EOF'
const { search } = require('./search');

const mockPosts = [
    { title: 'Hello World', content: 'This is a test' },
    { title: 'Another Post', content: 'More content here' }
];

console.log('Testing search...');
const results = search('hello', mockPosts);
console.log('Results:', results.length);
EOF
git add src/search.test.js
git commit -m "Add basic tests for search"

echo -e "${GREEN}✅ feature/needs-cleanup branch created (5 messy commits)${NC}"

# Create branch for in-progress work
git checkout master
echo -e "${BLUE}🌿 Creating feature/in-progress branch...${NC}"
git checkout -b feature/in-progress

export GIT_AUTHOR_DATE="2024-01-18T14:00:00"
export GIT_COMMITTER_DATE="2024-01-18T14:00:00"
cat > src/notifications.js << 'EOF'
// Notification system
class NotificationManager {
    constructor() {
        this.notifications = [];
    }

    notify(userId, message) {
        this.notifications.push({ userId, message, read: false });
    }
}
module.exports = NotificationManager;
EOF
git add src/notifications.js
git commit -m "Start notification system"

echo -e "${GREEN}✅ feature/in-progress branch created${NC}"

# Return to master
git checkout master

# Continue developing on master
export GIT_AUTHOR_NAME="Sarah Chen"
export GIT_AUTHOR_EMAIL="sarah@example.com"
export GIT_COMMITTER_NAME="Sarah Chen"
export GIT_COMMITTER_EMAIL="sarah@example.com"

# Master commit 7: Add database module
export GIT_AUTHOR_DATE="2024-01-19T09:00:00"
export GIT_COMMITTER_DATE="2024-01-19T09:00:00"
cat > src/database.js << 'EOF'
// Database Module

class Database {
    constructor() {
        this.data = new Map();
    }

    async save(collection, id, data) {
        if (!this.data.has(collection)) {
            this.data.set(collection, new Map());
        }
        this.data.get(collection).set(id, data);
        return true;
    }

    async get(collection, id) {
        return this.data.get(collection)?.get(id);
    }

    async getAll(collection) {
        const collectionData = this.data.get(collection);
        return collectionData ? Array.from(collectionData.values()) : [];
    }

    async delete(collection, id) {
        return this.data.get(collection)?.delete(id) || false;
    }
}

module.exports = Database;
EOF
git add src/database.js
git commit -m "Add database abstraction layer

Provides unified interface for data operations."

# Master commit 8: Add configuration
export GIT_AUTHOR_DATE="2024-01-19T11:00:00"
export GIT_COMMITTER_DATE="2024-01-19T11:00:00"
cat > src/config.js << 'EOF'
// Configuration Module

const config = {
    app: {
        name: 'Blog Platform',
        version: '1.0.0',
        port: 3000
    },
    
    database: {
        type: 'memory',
        persistToDisk: false
    },
    
    features: {
        comments: true,
        likes: true,
        sharing: true,
        notifications: false
    },
    
    security: {
        sessionTimeout: 3600,
        maxLoginAttempts: 5
    }
};

module.exports = config;
EOF
git add src/config.js
git commit -m "Add application configuration

Centralized config for all modules."

# Switch to Mike Johnson
export GIT_AUTHOR_NAME="Mike Johnson"
export GIT_AUTHOR_EMAIL="mike@example.com"
export GIT_COMMITTER_NAME="Mike Johnson"
export GIT_COMMITTER_EMAIL="mike@example.com"

# Master commit 9: Add logging module
export GIT_AUTHOR_DATE="2024-01-19T14:00:00"
export GIT_COMMITTER_DATE="2024-01-19T14:00:00"
cat > src/logger.js << 'EOF'
// Logging Module

class Logger {
    constructor(moduleName) {
        this.moduleName = moduleName;
        this.logs = [];
    }

    info(message) {
        this.log('INFO', message);
    }

    error(message) {
        this.log('ERROR', message);
    }

    warn(message) {
        this.log('WARN', message);
    }

    log(level, message) {
        const entry = {
            timestamp: new Date().toISOString(),
            level,
            module: this.moduleName,
            message
        };
        
        this.logs.push(entry);
        console.log(`[${level}] ${this.moduleName}: ${message}`);
    }

    getLogs() {
        return this.logs;
    }
}

module.exports = Logger;
EOF
git add src/logger.js
git commit -m "Add logging infrastructure

Structured logging for debugging."

# Master commit 10: Add email module
export GIT_AUTHOR_DATE="2024-01-20T09:00:00"
export GIT_COMMITTER_DATE="2024-01-20T09:00:00"
cat > src/email.js << 'EOF'
// Email Module

class EmailService {
    constructor(config) {
        this.config = config;
        this.queue = [];
    }

    async sendEmail(to, subject, body) {
        const email = {
            to,
            subject,
            body,
            sentAt: new Date(),
            status: 'sent'
        };
        
        this.queue.push(email);
        console.log(`Email sent to ${to}: ${subject}`);
        return true;
    }

    async sendWelcomeEmail(username, email) {
        return this.sendEmail(
            email,
            'Welcome to Blog Platform!',
            `Hi ${username}, welcome to our platform!`
        );
    }

    async sendNotification(email, message) {
        return this.sendEmail(
            email,
            'New Notification',
            message
        );
    }
}

module.exports = EmailService;
EOF
git add src/email.js
git commit -m "Add email service module

Support for sending emails and notifications."

# Create feature/search-improvements
git checkout -b feature/search-improvements

export GIT_AUTHOR_NAME="David Kim"
export GIT_AUTHOR_EMAIL="david@example.com"
export GIT_COMMITTER_NAME="David Kim"
export GIT_COMMITTER_EMAIL="david@example.com"

export GIT_AUTHOR_DATE="2024-01-20T11:00:00"
export GIT_COMMITTER_DATE="2024-01-20T11:00:00"
cat > src/search.js << 'EOF'
// Advanced Search Module

class SearchEngine {
    constructor(posts) {
        this.posts = posts || [];
        this.index = this.buildIndex();
    }

    buildIndex() {
        const index = new Map();
        
        this.posts.forEach(post => {
            const words = this.tokenize(post.title + ' ' + post.content);
            words.forEach(word => {
                if (!index.has(word)) {
                    index.set(word, []);
                }
                index.get(word).push(post.id);
            });
        });
        
        return index;
    }

    tokenize(text) {
        return text
            .toLowerCase()
            .replace(/[^\w\s]/g, '')
            .split(/\s+/)
            .filter(word => word.length > 2);
    }

    search(query) {
        const words = this.tokenize(query);
        const results = new Map();
        
        words.forEach(word => {
            const postIds = this.index.get(word) || [];
            postIds.forEach(id => {
                results.set(id, (results.get(id) || 0) + 1);
            });
        });
        
        return Array.from(results.entries())
            .sort((a, b) => b[1] - a[1])
            .map(([id]) => this.posts.find(p => p.id === id));
    }
}

module.exports = SearchEngine;
EOF
git add src/search.js
git commit -m "Implement advanced search with indexing

Full-text search with relevance ranking."

export GIT_AUTHOR_DATE="2024-01-20T13:00:00"
export GIT_COMMITTER_DATE="2024-01-20T13:00:00"
cat >> src/search.js << 'EOF'

    searchByTag(tag) {
        return this.posts.filter(post => 
            post.tags && post.tags.includes(tag)
        );
    }

    searchByAuthor(authorId) {
        return this.posts.filter(post => post.authorId === authorId);
    }
};

module.exports = SearchEngine;
EOF
git add src/search.js
git commit -m "Add tag and author search filters"

# Back to master
git checkout master

# Create feature/rich-text-editor
git checkout -b feature/rich-text-editor

export GIT_AUTHOR_NAME="Sarah Chen"
export GIT_AUTHOR_EMAIL="sarah@example.com"
export GIT_COMMITTER_NAME="Sarah Chen"
export GIT_COMMITTER_EMAIL="sarah@example.com"

export GIT_AUTHOR_DATE="2024-01-21T09:00:00"
export GIT_COMMITTER_DATE="2024-01-21T09:00:00"
cat > src/editor.js << 'EOF'
// Rich Text Editor Module

class RichTextEditor {
    constructor(elementId) {
        this.element = document.getElementById(elementId);
        this.content = '';
    }

    initialize() {
        this.setupToolbar();
        this.setupEventListeners();
    }

    setupToolbar() {
        const toolbar = document.createElement('div');
        toolbar.className = 'editor-toolbar';
        toolbar.innerHTML = `
            <button onclick="formatBold()">B</button>
            <button onclick="formatItalic()">I</button>
            <button onclick="insertLink()">Link</button>
        `;
        this.element.parentNode.insertBefore(toolbar, this.element);
    }

    setupEventListeners() {
        this.element.addEventListener('input', () => {
            this.content = this.element.innerHTML;
        });
    }

    getContent() {
        return this.content;
    }

    setContent(html) {
        this.element.innerHTML = html;
        this.content = html;
    }
}

module.exports = RichTextEditor;
EOF
git add src/editor.js
git commit -m "Add rich text editor component

Basic formatting toolbar and content management."

export GIT_AUTHOR_DATE="2024-01-21T11:00:00"
export GIT_COMMITTER_DATE="2024-01-21T11:00:00"
cat >> src/editor.js << 'EOF'

    insertImage(url) {
        const img = `<img src="${url}" alt="Image" class="editor-image">`;
        document.execCommand('insertHTML', false, img);
    }

    formatCode(code) {
        const pre = `<pre><code>${code}</code></pre>`;
        document.execCommand('insertHTML', false, pre);
    }
};

module.exports = RichTextEditor;
EOF
git add src/editor.js
git commit -m "Add image and code block support to editor"

# Back to master and continue
git checkout master

export GIT_AUTHOR_NAME="Emily Rodriguez"
export GIT_AUTHOR_EMAIL="emily@example.com"
export GIT_COMMITTER_NAME="Emily Rodriguez"
export GIT_COMMITTER_EMAIL="emily@example.com"

# Master commit 11: Add categories
export GIT_AUTHOR_DATE="2024-01-21T14:00:00"
export GIT_COMMITTER_DATE="2024-01-21T14:00:00"
cat > src/categories.js << 'EOF'
// Categories Module

class CategoryManager {
    constructor() {
        this.categories = new Map();
    }

    createCategory(name, description) {
        const id = this.generateId();
        this.categories.set(id, {
            id,
            name,
            description,
            postCount: 0
        });
        return id;
    }

    getCategory(id) {
        return this.categories.get(id);
    }

    getAllCategories() {
        return Array.from(this.categories.values());
    }

    assignPostToCategory(postId, categoryId) {
        const category = this.categories.get(categoryId);
        if (category) {
            category.postCount++;
        }
    }

    generateId() {
        return Math.random().toString(36).substr(2, 9);
    }
}

module.exports = CategoryManager;
EOF
git add src/categories.js
git commit -m "Add category management system

Organize posts by categories."

# Master commit 12: Add user profiles
export GIT_AUTHOR_DATE="2024-01-22T09:00:00"
export GIT_COMMITTER_DATE="2024-01-22T09:00:00"
cat > src/profiles.js << 'EOF'
// User Profiles Module

class ProfileManager {
    constructor() {
        this.profiles = new Map();
    }

    createProfile(userId, data) {
        this.profiles.set(userId, {
            userId,
            displayName: data.displayName,
            bio: data.bio || '',
            avatar: data.avatar || '',
            createdAt: new Date(),
            postCount: 0,
            followerCount: 0
        });
    }

    getProfile(userId) {
        return this.profiles.get(userId);
    }

    updateProfile(userId, updates) {
        const profile = this.profiles.get(userId);
        if (profile) {
            Object.assign(profile, updates);
        }
    }

    incrementPostCount(userId) {
        const profile = this.profiles.get(userId);
        if (profile) {
            profile.postCount++;
        }
    }
}

module.exports = ProfileManager;
EOF
git add src/profiles.js
git commit -m "Add user profile management

Track user data and statistics."

# Create feature/markdown-support
git checkout -b feature/markdown-support

export GIT_AUTHOR_NAME="David Kim"
export GIT_AUTHOR_EMAIL="david@example.com"
export GIT_COMMITTER_NAME="David Kim"
export GIT_COMMITTER_EMAIL="david@example.com"

export GIT_AUTHOR_DATE="2024-01-22T11:00:00"
export GIT_COMMITTER_DATE="2024-01-22T11:00:00"
cat > src/markdown.js << 'EOF'
// Markdown Parser Module

class MarkdownParser {
    parse(markdown) {
        let html = markdown;
        
        // Headers
        html = html.replace(/^### (.+)$/gm, '<h3>$1</h3>');
        html = html.replace(/^## (.+)$/gm, '<h2>$1</h2>');
        html = html.replace(/^# (.+)$/gm, '<h1>$1</h1>');
        
        // Bold and italic
        html = html.replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>');
        html = html.replace(/\*(.+?)\*/g, '<em>$1</em>');
        
        // Links
        html = html.replace(/\[(.+?)\]\((.+?)\)/g, '<a href="$2">$1</a>');
        
        // Code blocks
        html = html.replace(/```(.+?)```/gs, '<pre><code>$1</code></pre>');
        
        // Inline code
        html = html.replace(/`(.+?)`/g, '<code>$1</code>');
        
        return html;
    }
}

module.exports = MarkdownParser;
EOF
git add src/markdown.js
git commit -m "Add markdown parser

Convert markdown to HTML."

export GIT_AUTHOR_DATE="2024-01-22T13:00:00"
export GIT_COMMITTER_DATE="2024-01-22T13:00:00"
cat >> src/markdown.js << 'EOF'

    parseList(markdown) {
        // Unordered lists
        let html = markdown.replace(/^\* (.+)$/gm, '<li>$1</li>');
        html = html.replace(/(<li>.*<\/li>)/s, '<ul>$1</ul>');
        
        // Ordered lists
        html = html.replace(/^\d+\. (.+)$/gm, '<li>$1</li>');
        
        return html;
    }
};

module.exports = MarkdownParser;
EOF
git add src/markdown.js
git commit -m "Add list parsing to markdown"

# Back to master
git checkout master

export GIT_AUTHOR_NAME="Mike Johnson"
export GIT_AUTHOR_EMAIL="mike@example.com"
export GIT_COMMITTER_NAME="Mike Johnson"
export GIT_COMMITTER_EMAIL="mike@example.com"

# Master commit 13: Add analytics
export GIT_AUTHOR_DATE="2024-01-23T09:00:00"
export GIT_COMMITTER_DATE="2024-01-23T09:00:00"
cat > src/analytics.js << 'EOF'
// Analytics Module

class Analytics {
    constructor() {
        this.events = [];
        this.pageViews = new Map();
    }

    trackEvent(category, action, label) {
        this.events.push({
            timestamp: new Date(),
            category,
            action,
            label
        });
    }

    trackPageView(url) {
        const count = this.pageViews.get(url) || 0;
        this.pageViews.set(url, count + 1);
    }

    getStats() {
        return {
            totalEvents: this.events.length,
            totalPageViews: Array.from(this.pageViews.values())
                .reduce((sum, count) => sum + count, 0),
            topPages: this.getTopPages(5)
        };
    }

    getTopPages(limit) {
        return Array.from(this.pageViews.entries())
            .sort((a, b) => b[1] - a[1])
            .slice(0, limit);
    }
}

module.exports = Analytics;
EOF
git add src/analytics.js
git commit -m "Add analytics tracking

Track events and page views."

# Master commit 14: Add media uploader
export GIT_AUTHOR_DATE="2024-01-23T11:00:00"
export GIT_COMMITTER_DATE="2024-01-23T11:00:00"
cat > src/media.js << 'EOF'
// Media Upload Module

class MediaUploader {
    constructor(maxSize = 5000000) {
        this.maxSize = maxSize;
        this.uploads = [];
    }

    async upload(file) {
        if (file.size > this.maxSize) {
            throw new Error('File too large');
        }

        const upload = {
            id: this.generateId(),
            filename: file.name,
            size: file.size,
            type: file.type,
            uploadedAt: new Date(),
            url: `/uploads/${file.name}`
        };

        this.uploads.push(upload);
        return upload;
    }

    getUpload(id) {
        return this.uploads.find(u => u.id === id);
    }

    deleteUpload(id) {
        const index = this.uploads.findIndex(u => u.id === id);
        if (index > -1) {
            this.uploads.splice(index, 1);
            return true;
        }
        return false;
    }

    generateId() {
        return Math.random().toString(36).substr(2, 9);
    }
}

module.exports = MediaUploader;
EOF
git add src/media.js
git commit -m "Add media upload functionality

Support for image and file uploads."

# Create feature/social-features
git checkout -b feature/social-features

export GIT_AUTHOR_NAME="Emily Rodriguez"
export GIT_AUTHOR_EMAIL="emily@example.com"
export GIT_COMMITTER_NAME="Emily Rodriguez"
export GIT_COMMITTER_EMAIL="emily@example.com"

export GIT_AUTHOR_DATE="2024-01-24T09:00:00"
export GIT_COMMITTER_DATE="2024-01-24T09:00:00"
cat > src/social.js << 'EOF'
// Social Features Module

class SocialManager {
    constructor() {
        this.followers = new Map();
        this.likes = new Map();
        this.shares = [];
    }

    follow(followerId, followeeId) {
        if (!this.followers.has(followeeId)) {
            this.followers.set(followeeId, new Set());
        }
        this.followers.get(followeeId).add(followerId);
    }

    unfollow(followerId, followeeId) {
        const followers = this.followers.get(followeeId);
        if (followers) {
            followers.delete(followerId);
        }
    }

    getFollowers(userId) {
        return Array.from(this.followers.get(userId) || []);
    }

    getFollowerCount(userId) {
        return this.getFollowers(userId).length;
    }

    likePost(userId, postId) {
        if (!this.likes.has(postId)) {
            this.likes.set(postId, new Set());
        }
        this.likes.get(postId).add(userId);
    }

    getLikeCount(postId) {
        return (this.likes.get(postId) || new Set()).size;
    }

    sharePost(userId, postId) {
        this.shares.push({
            userId,
            postId,
            sharedAt: new Date()
        });
    }
}

module.exports = SocialManager;
EOF
git add src/social.js
git commit -m "Add social features: follow, like, share

Enable user interactions."

export GIT_AUTHOR_DATE="2024-01-24T11:00:00"
export GIT_COMMITTER_DATE="2024-01-24T11:00:00"
cat >> src/social.js << 'EOF'

    getFeed(userId) {
        const following = this.getFollowing(userId);
        // Return posts from followed users
        return [];
    }

    getFollowing(userId) {
        const following = [];
        for (let [followeeId, followers] of this.followers.entries()) {
            if (followers.has(userId)) {
                following.push(followeeId);
            }
        }
        return following;
    }
};

module.exports = SocialManager;
EOF
git add src/social.js
git commit -m "Add feed generation for followed users"

# Back to master
git checkout master

export GIT_AUTHOR_NAME="Sarah Chen"
export GIT_AUTHOR_EMAIL="sarah@example.com"
export GIT_COMMITTER_NAME="Sarah Chen"
export GIT_COMMITTER_EMAIL="sarah@example.com"

# Master commit 15: Add moderation
export GIT_AUTHOR_DATE="2024-01-24T14:00:00"
export GIT_COMMITTER_DATE="2024-01-24T14:00:00"
cat > src/moderation.js << 'EOF'
// Content Moderation Module

class ModerationManager {
    constructor() {
        this.reports = [];
        this.bannedWords = new Set(['spam', 'offensive']);
    }

    reportContent(contentId, reporterId, reason) {
        this.reports.push({
            id: this.generateId(),
            contentId,
            reporterId,
            reason,
            status: 'pending',
            createdAt: new Date()
        });
    }

    reviewReport(reportId, decision) {
        const report = this.reports.find(r => r.id === reportId);
        if (report) {
            report.status = decision;
            report.reviewedAt = new Date();
        }
    }

    checkContent(text) {
        const lower = text.toLowerCase();
        for (let word of this.bannedWords) {
            if (lower.includes(word)) {
                return { allowed: false, reason: 'Contains banned words' };
            }
        }
        return { allowed: true };
    }

    generateId() {
        return Math.random().toString(36).substr(2, 9);
    }
}

module.exports = ModerationManager;
EOF
git add src/moderation.js
git commit -m "Add content moderation system

Report and review inappropriate content."

# Master commit 16: Add RSS feed
export GIT_AUTHOR_DATE="2024-01-25T09:00:00"
export GIT_COMMITTER_DATE="2024-01-25T09:00:00"
cat > src/rss.js << 'EOF'
// RSS Feed Generator

class RSSGenerator {
    constructor(blogInfo) {
        this.blogInfo = blogInfo;
    }

    generateFeed(posts) {
        const items = posts.map(post => this.generateItem(post)).join('');
        
        return `<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
  <channel>
    <title>${this.blogInfo.title}</title>
    <link>${this.blogInfo.url}</link>
    <description>${this.blogInfo.description}</description>
    ${items}
  </channel>
</rss>`;
    }

    generateItem(post) {
        return `
    <item>
      <title>${this.escapeXml(post.title)}</title>
      <link>${this.blogInfo.url}/posts/${post.id}</link>
      <description>${this.escapeXml(post.content)}</description>
      <pubDate>${post.createdAt.toUTCString()}</pubDate>
    </item>`;
    }

    escapeXml(text) {
        return text
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;');
    }
}

module.exports = RSSGenerator;
EOF
git add src/rss.js
git commit -m "Add RSS feed generation

Allow users to subscribe via RSS."

# Create feature/performance
git checkout -b feature/performance

export GIT_AUTHOR_NAME="David Kim"
export GIT_AUTHOR_EMAIL="david@example.com"
export GIT_COMMITTER_NAME="David Kim"
export GIT_COMMITTER_EMAIL="david@example.com"

export GIT_AUTHOR_DATE="2024-01-25T11:00:00"
export GIT_COMMITTER_DATE="2024-01-25T11:00:00"
cat > src/cache.js << 'EOF'
// Caching Module

class Cache {
    constructor(ttl = 3600) {
        this.cache = new Map();
        this.ttl = ttl;
    }

    set(key, value) {
        this.cache.set(key, {
            value,
            expires: Date.now() + (this.ttl * 1000)
        });
    }

    get(key) {
        const item = this.cache.get(key);
        
        if (!item) return null;
        
        if (Date.now() > item.expires) {
            this.cache.delete(key);
            return null;
        }
        
        return item.value;
    }

    clear() {
        this.cache.clear();
    }

    size() {
        return this.cache.size;
    }
}

module.exports = Cache;
EOF
git add src/cache.js
git commit -m "Add caching layer for performance

Cache frequently accessed data."

export GIT_AUTHOR_DATE="2024-01-25T13:00:00"
export GIT_COMMITTER_DATE="2024-01-25T13:00:00"
cat >> src/cache.js << 'EOF'

    cleanup() {
        const now = Date.now();
        for (let [key, item] of this.cache.entries()) {
            if (now > item.expires) {
                this.cache.delete(key);
            }
        }
    }
};

module.exports = Cache;
EOF
git add src/cache.js
git commit -m "Add automatic cache cleanup"

# Back to master and add final commits
git checkout master

export GIT_AUTHOR_NAME="Mike Johnson"
export GIT_AUTHOR_EMAIL="mike@example.com"
export GIT_COMMITTER_NAME="Mike Johnson"
export GIT_COMMITTER_EMAIL="mike@example.com"

# Master commit 17: Add SEO
export GIT_AUTHOR_DATE="2024-01-26T09:00:00"
export GIT_COMMITTER_DATE="2024-01-26T09:00:00"
cat > src/seo.js << 'EOF'
// SEO Module

class SEOManager {
    generateMetaTags(post) {
        return {
            title: post.title,
            description: this.truncate(post.content, 160),
            keywords: post.tags ? post.tags.join(', ') : '',
            ogTitle: post.title,
            ogDescription: this.truncate(post.content, 200),
            ogImage: post.imageUrl || '/default-og-image.jpg'
        };
    }

    generateSitemap(posts) {
        const urls = posts.map(post => 
            `<url>
    <loc>https://example.com/posts/${post.id}</loc>
    <lastmod>${post.updatedAt || post.createdAt}</lastmod>
    <priority>0.8</priority>
  </url>`
        ).join('\n');

        return `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  ${urls}
</urlset>`;
    }

    truncate(text, length) {
        return text.length > length ? 
            text.substring(0, length) + '...' : 
            text;
    }
}

module.exports = SEOManager;
EOF
git add src/seo.js
git commit -m "Add SEO optimization tools

Generate meta tags and sitemap."

# Master commit 18: Add README
export GIT_AUTHOR_DATE="2024-01-26T11:00:00"
export GIT_COMMITTER_DATE="2024-01-26T11:00:00"
cat > README.md << 'EOF'
# Blog Platform

A full-featured blogging platform built with Node.js.

## Features

- User authentication and profiles
- Rich text editor with markdown support
- Comments and social features
- Search and categories
- Analytics and SEO
- Media uploads
- Content moderation

## Getting Started

```bash
npm install
npm start
```

## Development

See CONTRIBUTING.md for development guidelines.
EOF
git add README.md
git commit -m "Add comprehensive README"

echo ""
echo -e "${GREEN}✅ Git history setup complete!${NC}"
echo ""
echo -e "${BLUE}📊 Repository Summary:${NC}"
echo "  • Master branch: 18 commits with full feature set"
echo "  • feature/posts-ui: ready for clean rebase"
echo "  • feature/comments-system: ready for rebase"
echo "  • feature/auth-system: ready for fast-forward"
echo "  • feature/posts-api: will have conflicts with master"
echo "  • feature/complex-changes: many conflicts (for abort practice)"
echo "  • feature/needs-cleanup: messy commits (for interactive rebase)"
echo "  • feature/in-progress: simulates ongoing work"
echo "  • feature/search-improvements: advanced search features"
echo "  • feature/rich-text-editor: editor enhancements"
echo "  • feature/markdown-support: markdown parsing"
echo "  • feature/social-features: follow/like/share"
echo "  • feature/performance: caching improvements"
echo ""
echo -e "${BLUE}🎯 Ready for exercises!${NC}"
echo "  Run: git log --oneline --graph --all"
echo "  Start with: EXERCISES.md"
echo ""
